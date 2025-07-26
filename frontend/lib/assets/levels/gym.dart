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
        "x": 10,
        "y": 10
      },
      "angle": 0.0
    },
    {
      "id": "2",
      "position": {
        "x": 10,
        "y": 90
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
  "turrets": [
    {
      "id": "turret1",
      "position": {
        "x": 60,
        "y": 35
      },
      "angle": 0.0,
      "lasers": [
        {
          "angle": 0.0,
          "aperture": 20.0,
          "range": 50.0
        }
      ],
      "behaviors": [
        {
          "type": "rotating",
          "trigger": null,
          "startX": null,
          "startY": null,
          "startAngle": 0.0,
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
          "minAngle": -15.0,
          "maxAngle": 15.0,
          "periodX": null,
          "periodY": null,
          "amplitudeX": null,
          "amplitudeY": null,
          "timeOn": null,
          "timeOff": null,
          "initialTime": null,
          "rotatingDirection": "clockwise",
          "intermittentState": null
        }
      ]
    },
    {
      "id": "turret2",
      "position": {
        "x": 10,
        "y": 25
      },
      "angle": 90.0,
      "lasers": [
        {
          "angle": 0.0,
          "aperture": 50.0,
          "range": 50.0
        }
      ],
      "behaviors": [
        {
          "type": "rotating",
          "trigger": null,
          "startX": null,
          "startY": null,
          "startAngle": 0.0,
          "speed": 70.0,
          "speedX": null,
          "speedY": null,
          "centerX": null,
          "centerY": null,
          "radius": null,
          "minX": null,
          "maxX": null,
          "minY": null,
          "maxY": null,
          "minAngle": -180.0,
          "maxAngle": -90.0,
          "periodX": null,
          "periodY": null,
          "amplitudeX": null,
          "amplitudeY": null,
          "timeOn": null,
          "timeOff": null,
          "initialTime": null,
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
          "x": 0,
          "y": 0
        },
        {
          "x": 175,
          "y": 0
        },
        {
          "x": 175,
          "y": 5
        },
        {
          "x": 0,
          "y": 5
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 40,
          "y": 15
        },
        {
          "x": 55,
          "y": 15
        },
        {
          "x": 55,
          "y": 20
        },
        {
          "x": 40,
          "y": 20
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 20,
          "y": 35
        },
        {
          "x": 30,
          "y": 35
        },
        {
          "x": 30,
          "y": 45
        },
        {
          "x": 20,
          "y": 45
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 65,
          "y": 15
        },
        {
          "x": 70,
          "y": 15
        },
        {
          "x": 70,
          "y": 45
        },
        {
          "x": 65,
          "y": 45
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 65,
          "y": 55
        },
        {
          "x": 70,
          "y": 55
        },
        {
          "x": 70,
          "y": 65
        },
        {
          "x": 65,
          "y": 65
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 50,
          "y": 55
        },
        {
          "x": 55,
          "y": 55
        },
        {
          "x": 55,
          "y": 65
        },
        {
          "x": 50,
          "y": 65
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 5,
          "y": 60
        },
        {
          "x": 50,
          "y": 60
        },
        {
          "x": 50,
          "y": 65
        },
        {
          "x": 5,
          "y": 65
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 50,
          "y": 20
        },
        {
          "x": 55,
          "y": 20
        },
        {
          "x": 55,
          "y": 45
        },
        {
          "x": 50,
          "y": 45
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
          "y": 15
        },
        {
          "x": 30,
          "y": 15
        },
        {
          "x": 30,
          "y": 20
        },
        {
          "x": 5,
          "y": 20
        }
      ]
    }
  ]
}
''';
}
