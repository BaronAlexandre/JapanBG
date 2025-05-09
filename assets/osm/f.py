import requests
import xml.etree.ElementTree as ET

# URL corrigée pour récupérer aussi les tags (et donc les noms)
API_URL = "https://overpass-api.de/api/interpreter?data=[out:xml];relation(8028808);out body;>;out body qt;"

def fetch_metro_data(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.content
    else:
        raise Exception(f"Failed to fetch data: {response.status_code}")

def parse_metro_data(xml_data):
    root = ET.fromstring(xml_data)
    metro_data = {
        'stops': {},
        'paths': {}
    }

    # Collect nodes (stops) with names (including English)
    for element in root.findall('node'):
        stop_info = {
            'lat': element.get('lat'),
            'lon': element.get('lon'),
            'name': None,       # Default: no name
            'name_en': None     # Default: no English name
        }
        # Rechercher les tags name et name:en
        for tag in element.findall('tag'):
            if tag.get('k') == 'name':
                stop_info['name'] = tag.get('v')
            elif tag.get('k') == 'name:en':
                stop_info['name_en'] = tag.get('v')
        metro_data['stops'][element.get('id')] = stop_info

    # Collect ways (paths)
    for element in root.findall('way'):
        metro_data['paths'][element.get('id')] = []
        for nd in element.findall('nd'):
            metro_data['paths'][element.get('id')].append(nd.get('ref'))

    # Collect relation data
    for relation in root.findall('relation'):
        metro_line = {
            'id': relation.get('id'),
            'stops': [],
            'paths': []
        }
        for member in relation.findall('member'):
            if member.get('role') == 'stop':
                metro_line['stops'].append(member.get('ref'))
            elif member.get('type') == 'way':
                metro_line['paths'].append(member.get('ref'))

        metro_data['relation'] = metro_line

    return metro_data

def create_xml(metro_data, output_file):
    root = ET.Element("osm", version="0.6", generator="custom_script")

    relation = ET.SubElement(root, "relation", id=metro_data['relation']['id'], visible="true", version="1")

    for stop_id in metro_data['relation']['stops']:
        stop = metro_data['stops'][stop_id]
        member = ET.SubElement(relation, "member", type="node", ref=stop_id, role="stop", lat=stop['lat'], lon=stop['lon'])

        # Ajouter name et name:en dans les attributs si disponibles
        if stop['name']:
            member.set('name', stop['name'])
        if stop['name_en']:
            member.set('name_en', stop['name_en'])

    for path_id in metro_data['relation']['paths']:
        path = metro_data['paths'][path_id]
        way = ET.SubElement(relation, "member", type="way", ref=path_id, role="platform")
        for node_id in path:
            node = metro_data['stops'].get(node_id)
            if node:
                nd = ET.SubElement(way, "nd", ref=node_id, lat=node['lat'], lon=node['lon'])
                if node['name']:
                    nd.set('name', node['name'])
                if node['name_en']:
                    nd.set('name_en', node['name_en'])

    tree = ET.ElementTree(root)
    tree.write(output_file, encoding='utf-8', xml_declaration=True)

def main():
    xml_data = fetch_metro_data(API_URL)
    metro_data = parse_metro_data(xml_data)
    create_xml(metro_data, "f.xml")
    print("Fichier XML généré avec succès : f.xml")

if __name__ == "__main__":
    main()
