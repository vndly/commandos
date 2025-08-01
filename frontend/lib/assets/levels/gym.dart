class LevelGym {
  static const String JSON = '''
{
  "id": "gym",
  "width": 620,
  "height": 100,
  "agents": [
    {
      "id": "1",
      "position": {
        "x": 13,
        "y": 17
      },
      "angle": 0.0
    },
    {
      "id": "2",
      "position": {
        "x": 12,
        "y": 87
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
        "x": 60,
        "y": 40
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
        "x": 10,
        "y": 35
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
          "y": 5
        },
        {
          "x": 5,
          "y": 5
        },
        {
          "x": 5,
          "y": 100
        },
        {
          "x": 0,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 5
        },
        {
          "x": 175,
          "y": 5
        },
        {
          "x": 175,
          "y": 10
        },
        {
          "x": 5,
          "y": 10
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 40,
          "y": 25
        },
        {
          "x": 50,
          "y": 25
        },
        {
          "x": 50,
          "y": 30
        },
        {
          "x": 40,
          "y": 30
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 20,
          "y": 45
        },
        {
          "x": 30,
          "y": 45
        },
        {
          "x": 30,
          "y": 55
        },
        {
          "x": 20,
          "y": 55
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 65,
          "y": 25
        },
        {
          "x": 70,
          "y": 25
        },
        {
          "x": 70,
          "y": 60
        },
        {
          "x": 65,
          "y": 60
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 90,
          "y": 25
        },
        {
          "x": 95,
          "y": 25
        },
        {
          "x": 95,
          "y": 50
        },
        {
          "x": 90,
          "y": 50
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 120,
          "y": 25
        },
        {
          "x": 160,
          "y": 25
        },
        {
          "x": 160,
          "y": 35
        },
        {
          "x": 120,
          "y": 35
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 115,
          "y": 25
        },
        {
          "x": 120,
          "y": 25
        },
        {
          "x": 120,
          "y": 50
        },
        {
          "x": 115,
          "y": 50
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 160,
          "y": 25
        },
        {
          "x": 165,
          "y": 25
        },
        {
          "x": 165,
          "y": 50
        },
        {
          "x": 160,
          "y": 50
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 160,
          "y": 60
        },
        {
          "x": 165,
          "y": 60
        },
        {
          "x": 165,
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
          "x": 115,
          "y": 60
        },
        {
          "x": 120,
          "y": 60
        },
        {
          "x": 120,
          "y": 80
        },
        {
          "x": 115,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 120,
          "y": 75
        },
        {
          "x": 135,
          "y": 75
        },
        {
          "x": 135,
          "y": 80
        },
        {
          "x": 120,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 145,
          "y": 75
        },
        {
          "x": 160,
          "y": 75
        },
        {
          "x": 160,
          "y": 80
        },
        {
          "x": 145,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 80,
          "y": 35
        },
        {
          "x": 105,
          "y": 35
        },
        {
          "x": 105,
          "y": 40
        },
        {
          "x": 80,
          "y": 40
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 65,
          "y": 70
        },
        {
          "x": 70,
          "y": 70
        },
        {
          "x": 70,
          "y": 80
        },
        {
          "x": 65,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 50,
          "y": 70
        },
        {
          "x": 55,
          "y": 70
        },
        {
          "x": 55,
          "y": 80
        },
        {
          "x": 50,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 75
        },
        {
          "x": 20,
          "y": 75
        },
        {
          "x": 20,
          "y": 80
        },
        {
          "x": 5,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 30,
          "y": 75
        },
        {
          "x": 50,
          "y": 75
        },
        {
          "x": 50,
          "y": 80
        },
        {
          "x": 30,
          "y": 80
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 50,
          "y": 25
        },
        {
          "x": 55,
          "y": 25
        },
        {
          "x": 55,
          "y": 60
        },
        {
          "x": 50,
          "y": 60
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 95
        },
        {
          "x": 175,
          "y": 95
        },
        {
          "x": 175,
          "y": 100
        },
        {
          "x": 5,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 25
        },
        {
          "x": 30,
          "y": 25
        },
        {
          "x": 30,
          "y": 30
        },
        {
          "x": 5,
          "y": 30
        }
      ]
    }
  ]
}
''';
}
