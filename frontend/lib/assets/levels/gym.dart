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
        "x": 25,
        "y": 25
      }
    },
    {
      "id": "2",
      "position": {
        "x": 25,
        "y": 175
      }
    },
    {
      "id": "3",
      "position": {
        "x": 365,
        "y": 25
      }
    }
  ],
  "turrets": [],
  "soldiers": [
    {
      "id": "soldier1",
      "position": {
        "x": 135,
        "y": 80
      },
      "angle": -90.0,
      "sweep": 30.0,
      "range": 100.0,
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
          "rotatingDirection": "clockwise",
          "intermittentState": null
        }
      ]
    },
    {
      "id": "soldier2",
      "position": {
        "x": 20,
        "y": 60
      },
      "angle": 45.0,
      "sweep": 30.0,
      "range": 100.0,
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
          "y": 0
        },
        {
          "x": 10,
          "y": 0
        },
        {
          "x": 10,
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
          "x": 10,
          "y": 0
        },
        {
          "x": 380,
          "y": 0
        },
        {
          "x": 380,
          "y": 10
        },
        {
          "x": 10,
          "y": 10
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 90,
          "y": 40
        },
        {
          "x": 110,
          "y": 40
        },
        {
          "x": 110,
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
          "x": 40,
          "y": 80
        },
        {
          "x": 60,
          "y": 80
        },
        {
          "x": 60,
          "y": 100
        },
        {
          "x": 40,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 150,
          "y": 40
        },
        {
          "x": 160,
          "y": 40
        },
        {
          "x": 160,
          "y": 100
        },
        {
          "x": 150,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 200,
          "y": 40
        },
        {
          "x": 210,
          "y": 40
        },
        {
          "x": 210,
          "y": 90
        },
        {
          "x": 200,
          "y": 90
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 270,
          "y": 40
        },
        {
          "x": 370,
          "y": 40
        },
        {
          "x": 370,
          "y": 50
        },
        {
          "x": 270,
          "y": 50
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 260,
          "y": 40
        },
        {
          "x": 270,
          "y": 40
        },
        {
          "x": 270,
          "y": 90
        },
        {
          "x": 260,
          "y": 90
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 370,
          "y": 40
        },
        {
          "x": 380,
          "y": 40
        },
        {
          "x": 380,
          "y": 90
        },
        {
          "x": 370,
          "y": 90
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 370,
          "y": 110
        },
        {
          "x": 380,
          "y": 110
        },
        {
          "x": 380,
          "y": 160
        },
        {
          "x": 370,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 260,
          "y": 110
        },
        {
          "x": 270,
          "y": 110
        },
        {
          "x": 270,
          "y": 160
        },
        {
          "x": 260,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 270,
          "y": 150
        },
        {
          "x": 310,
          "y": 150
        },
        {
          "x": 310,
          "y": 160
        },
        {
          "x": 270,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 330,
          "y": 150
        },
        {
          "x": 370,
          "y": 150
        },
        {
          "x": 370,
          "y": 160
        },
        {
          "x": 330,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 180,
          "y": 60
        },
        {
          "x": 230,
          "y": 60
        },
        {
          "x": 230,
          "y": 70
        },
        {
          "x": 180,
          "y": 70
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 150,
          "y": 120
        },
        {
          "x": 160,
          "y": 120
        },
        {
          "x": 160,
          "y": 160
        },
        {
          "x": 150,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 110,
          "y": 120
        },
        {
          "x": 120,
          "y": 120
        },
        {
          "x": 120,
          "y": 160
        },
        {
          "x": 110,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 10,
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
          "x": 10,
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
          "x": 110,
          "y": 150
        },
        {
          "x": 110,
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
          "x": 110,
          "y": 40
        },
        {
          "x": 120,
          "y": 40
        },
        {
          "x": 120,
          "y": 100
        },
        {
          "x": 110,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 10,
          "y": 190
        },
        {
          "x": 380,
          "y": 190
        },
        {
          "x": 380,
          "y": 200
        },
        {
          "x": 10,
          "y": 200
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 10,
          "y": 40
        },
        {
          "x": 70,
          "y": 40
        },
        {
          "x": 70,
          "y": 50
        },
        {
          "x": 10,
          "y": 50
        }
      ]
    }
  ],
  "doors": [
    {
      "status": "closed",
      "vertices": [
        {
          "x": 40,
          "y": 150
        },
        {
          "x": 60,
          "y": 150
        },
        {
          "x": 60,
          "y": 160
        },
        {
          "x": 40,
          "y": 160
        }
      ]
    },
    {
      "status": "closed",
      "vertices": [
        {
          "x": 260,
          "y": 110
        },
        {
          "x": 260,
          "y": 90
        },
        {
          "x": 270,
          "y": 90
        },
        {
          "x": 270,
          "y": 110
        }
      ]
    }
  ],
  "items": [
    {
      "type": "keycard",
      "position": {
        "x": 204,
        "y": 145
      }
    },
    {
      "type": "keycard",
      "position": {
        "x": 34,
        "y": 125
      }
    }
  ]
}
''';
}
