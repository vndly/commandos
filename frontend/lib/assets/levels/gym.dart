class LevelGym {
  static const String JSON = '''
{
  "id": "gym",
  "width": 1000,
  "height": 200,
  "agents": [
    {
      "id": "1",
      "position": {
        "x": 17,
        "y": 33
      },
      "angle": 0.0
    },
    {
      "id": "2",
      "position": {
        "x": 17,
        "y": 173
      },
      "angle": 0.0
    },
    {
      "id": "3",
      "position": {
        "x": 605,
        "y": 15
      },
      "angle": 0.0
    }
  ],
  "turrets": [],
  "soldiers": [
    {
      "id": "soldier1",
      "position": {
        "x": 120,
        "y": 80
      },
      "headAngle": -90.0,
      "bodyAngle": -90.0,
      "sweep": 30.0,
      "range": 50.0,
      "behaviors": [
        {
          "type": "rotating",
          "trigger": null,
          "startX": null,
          "startY": null,
          "startAngle": -90.0,
          "speed": 50.0,
          "speedX": null,
          "speedY": null,
          "centerX": null,
          "centerY": null,
          "radius": null,
          "minX": null,
          "maxX": null,
          "minY": null,
          "maxY": null,
          "minAngle": -120.0,
          "maxAngle": -60.0,
          "periodX": null,
          "periodY": null,
          "amplitudeX": null,
          "amplitudeY": null,
          "timeOn": null,
          "timeOff": null,
          "initialTime": null,
          "rotatingPart": "head",
          "rotatingDirection": "clockwise",
          "intermittentState": null
        }
      ]
    },
    {
      "id": "soldier2",
      "position": {
        "x": 20,
        "y": 70
      },
      "headAngle": 45.0,
      "bodyAngle": 45.0,
      "sweep": 30.0,
      "range": 50.0,
      "behaviors": [
        {
          "type": "rotating",
          "trigger": null,
          "startX": null,
          "startY": null,
          "startAngle": 45.0,
          "speed": 40.0,
          "speedX": null,
          "speedY": null,
          "centerX": null,
          "centerY": null,
          "radius": null,
          "minX": null,
          "maxX": null,
          "minY": null,
          "maxY": null,
          "minAngle": 25.0,
          "maxAngle": 65.0,
          "periodX": null,
          "periodY": null,
          "amplitudeX": null,
          "amplitudeY": null,
          "timeOn": null,
          "timeOff": null,
          "initialTime": null,
          "rotatingPart": "head",
          "rotatingDirection": "counter_clockwise",
          "intermittentState": null
        }
      ]
    }
  ],
  "walls": [
    {
      "vertices": [
        {
          "x": 0,
          "y": 10
        },
        {
          "x": 5,
          "y": 10
        },
        {
          "x": 5,
          "y": 200
        },
        {
          "x": 0,
          "y": 200
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 10
        },
        {
          "x": 360,
          "y": 10
        },
        {
          "x": 360,
          "y": 20
        },
        {
          "x": 5,
          "y": 20
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 80,
          "y": 50
        },
        {
          "x": 105,
          "y": 50
        },
        {
          "x": 105,
          "y": 60
        },
        {
          "x": 80,
          "y": 60
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 40,
          "y": 100
        },
        {
          "x": 50,
          "y": 100
        },
        {
          "x": 50,
          "y": 110
        },
        {
          "x": 40,
          "y": 110
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 130,
          "y": 50
        },
        {
          "x": 135,
          "y": 50
        },
        {
          "x": 135,
          "y": 120
        },
        {
          "x": 130,
          "y": 120
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 180,
          "y": 50
        },
        {
          "x": 185,
          "y": 50
        },
        {
          "x": 185,
          "y": 100
        },
        {
          "x": 180,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 240,
          "y": 50
        },
        {
          "x": 320,
          "y": 50
        },
        {
          "x": 320,
          "y": 70
        },
        {
          "x": 240,
          "y": 70
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 235,
          "y": 50
        },
        {
          "x": 240,
          "y": 50
        },
        {
          "x": 240,
          "y": 100
        },
        {
          "x": 235,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 320,
          "y": 50
        },
        {
          "x": 325,
          "y": 50
        },
        {
          "x": 325,
          "y": 100
        },
        {
          "x": 320,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 320,
          "y": 120
        },
        {
          "x": 325,
          "y": 120
        },
        {
          "x": 325,
          "y": 160
        },
        {
          "x": 320,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 235,
          "y": 120
        },
        {
          "x": 240,
          "y": 120
        },
        {
          "x": 240,
          "y": 160
        },
        {
          "x": 235,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 240,
          "y": 150
        },
        {
          "x": 270,
          "y": 150
        },
        {
          "x": 270,
          "y": 160
        },
        {
          "x": 240,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 290,
          "y": 150
        },
        {
          "x": 320,
          "y": 150
        },
        {
          "x": 320,
          "y": 160
        },
        {
          "x": 290,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 160,
          "y": 70
        },
        {
          "x": 205,
          "y": 70
        },
        {
          "x": 205,
          "y": 80
        },
        {
          "x": 160,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 130,
          "y": 140
        },
        {
          "x": 135,
          "y": 140
        },
        {
          "x": 135,
          "y": 160
        },
        {
          "x": 130,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 105,
          "y": 140
        },
        {
          "x": 110,
          "y": 140
        },
        {
          "x": 110,
          "y": 160
        },
        {
          "x": 105,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 150
        },
        {
          "x": 40,
          "y": 150
        },
        {
          "x": 40,
          "y": 160
        },
        {
          "x": 5,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 60,
          "y": 150
        },
        {
          "x": 105,
          "y": 150
        },
        {
          "x": 105,
          "y": 160
        },
        {
          "x": 60,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 105,
          "y": 50
        },
        {
          "x": 110,
          "y": 50
        },
        {
          "x": 110,
          "y": 120
        },
        {
          "x": 105,
          "y": 120
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 190
        },
        {
          "x": 359,
          "y": 190
        },
        {
          "x": 359,
          "y": 200
        },
        {
          "x": 5,
          "y": 200
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 50
        },
        {
          "x": 60,
          "y": 50
        },
        {
          "x": 60,
          "y": 60
        },
        {
          "x": 5,
          "y": 60
        }
      ]
    }
  ]
}
''';
}
