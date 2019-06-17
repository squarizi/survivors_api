# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version  2.4.0

* Database
  Postgres

* How to run the test suite
  Rspec

* API Routes

* Create Survivor Route
http://localhost:3000/v1/survivors

Json
{"survivor" : {
      "name": "Primeiro Survivor",
      "birth_date": "1980-08-30",
      "gender": 2,
      "last_location": {
          "lat": -14.211139,
          "lng": -51.328125
        },
      "items": [
        {"item_id": 1, "amount": 0},
        {"item_id": 2, "amount": 2},
        {"item_id": 3, "amount": 3},
        {"item_id": 4, "amount": 1}
      ]
  }
}

* Update Last Location
http://localhost:3000/v1/survivors/<survivor_id>/update_last_location

Json
{"survivor" : {
      "last_location": {
          "lat": -52.211139,
            "lng": -68.328125
        }
  }
}

* Complaint Route
http://localhost:3000/v1/complaints

Json
{"complaint" : {
      "complainer_id": 4,
      "contaminated_id": 1
  }
}

* Reports Route
http://localhost:3000/v1/reports

Json returns
  {
    cronenbergeds_survivors: float,
    clean_survivors: float,
    average_items_survivor: {
      ammunitions: float,
      medicines: float,
      foods: float,
      waters: float
    },
    lost_points: integer
  }

* Exchange Routes
http://localhost:3000/v1/survivors/<survivor_id>/exchange_items

Json
{
  "exchange" : {
    "items": [
      {"item_id": 1, "amount": 6}
    ],
    "exchanger": {
     "id": 6,
     "items": [
        {"item_id": 3,"amount": 2}
      ]
     }
  }
}