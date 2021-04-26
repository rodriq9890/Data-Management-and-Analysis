import db
import json

Session = db.get_session(db.generate_dsn('config.json'))
with open('../DPR_Eateries_001.json') as data:
    data = data.read()
    jsondata = json.loads(data)
eateries = [db.Eatery() for i in jsondata]

for num, row in enumerate(eateries):
    row.eatery_id = num
    row.name = jsondata[num]['name']
    row.location = jsondata[num]['location']
    row.park_id = jsondata[num]['park_id']
    row.start_date = jsondata[num]['start_date']
    row.end_date = jsondata[num]['end_date']
    row.description = jsondata[num]['description']
    row.permit_number = jsondata[num]['permit_number']
    row.phone = jsondata[num]['phone']
    row.website = jsondata[num]['website']
    row.type_name = jsondata[num]['type_name']

Session.add_all(eateries)
Session.commit()
