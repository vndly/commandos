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
        "x": 20,
        "y": 20
      }
    },
    {
      "id": "2",
      "position": {
        "x": 20,
        "y": 180
      }
    },
    {
      "id": "3",
      "position": {
        "x": 365,
        "y": 20
      }
    }
  ],
  "turrets": [],
  "soldiers": [
    {
      "id": "soldier1",
      "position": {
        "x": 15,
        "y": 50
      },
      "angle": 45.0,
      "sweep": 30.0,
      "range": 120.0,
      "behaviors": [
        {
          "type": "rotating",
          "trigger": 0.0,
          "startX": 0.0,
          "startY": 0.0,
          "startAngle": 0.0,
          "speed": 0.0,
          "speedX": 0.0,
          "speedY": 0.0,
          "centerX": 0.0,
          "centerY": 0.0,
          "radius": 0.0,
          "minX": 0.0,
          "maxX": 0.0,
          "minY": 0.0,
          "maxY": 0.0,
          "minAngle": 0.0,
          "maxAngle": 0.0,
          "periodX": 0.0,
          "periodY": 0.0,
          "amplitudeX": 0.0,
          "amplitudeY": 0.0,
          "timeOn": 0.0,
          "timeOff": 0.0,
          "initialTime": 0.0,
          "rotatingDirection": "counter_clockwise",
          "intermittentState": null
        }
      ]
    },
    {
      "id": "soldier2",
      "position": {
        "x": 135,
        "y": 85
      },
      "angle": -90.0,
      "sweep": 30.0,
      "range": 100.0,
      "behaviors": [
        {
          "type": "rotating",
          "trigger": 0.0,
          "startX": 0.0,
          "startY": 0.0,
          "startAngle": 0.0,
          "speed": 0.0,
          "speedX": 0.0,
          "speedY": 0.0,
          "centerX": 0.0,
          "centerY": 0.0,
          "radius": 0.0,
          "minX": 0.0,
          "maxX": 0.0,
          "minY": 0.0,
          "maxY": 0.0,
          "minAngle": 0.0,
          "maxAngle": 0.0,
          "periodX": 0.0,
          "periodY": 0.0,
          "amplitudeX": 0.0,
          "amplitudeY": 0.0,
          "timeOn": 0.0,
          "timeOff": 0.0,
          "initialTime": 0.0,
          "rotatingDirection": "clockwise",
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
          "x": 5,
          "y": 0
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
          "x": 0,
          "y": 0
        },
        {
          "x": 380,
          "y": 0
        },
        {
          "x": 380,
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
          "x": 90,
          "y": 40
        },
        {
          "x": 120,
          "y": 40
        },
        {
          "x": 120,
          "y": 35
        },
        {
          "x": 90,
          "y": 35
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
          "y": 35
        },
        {
          "x": 155,
          "y": 35
        },
        {
          "x": 155,
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
          "x": 205,
          "y": 40
        },
        {
          "x": 210,
          "y": 40
        },
        {
          "x": 210,
          "y": 95
        },
        {
          "x": 205,
          "y": 95
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 260,
          "y": 35
        },
        {
          "x": 380,
          "y": 35
        },
        {
          "x": 380,
          "y": 40
        },
        {
          "x": 260,
          "y": 40
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 260,
          "y": 35
        },
        {
          "x": 265,
          "y": 35
        },
        {
          "x": 265,
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
          "x": 375,
          "y": 35
        },
        {
          "x": 380,
          "y": 35
        },
        {
          "x": 380,
          "y": 90
        },
        {
          "x": 375,
          "y": 90
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 375,
          "y": 110
        },
        {
          "x": 380,
          "y": 110
        },
        {
          "x": 380,
          "y": 165
        },
        {
          "x": 375,
          "y": 165
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
          "x": 265,
          "y": 110
        },
        {
          "x": 265,
          "y": 165
        },
        {
          "x": 260,
          "y": 165
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 260,
          "y": 160
        },
        {
          "x": 310,
          "y": 160
        },
        {
          "x": 310,
          "y": 165
        },
        {
          "x": 260,
          "y": 165
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 330,
          "y": 160
        },
        {
          "x": 380,
          "y": 160
        },
        {
          "x": 380,
          "y": 165
        },
        {
          "x": 330,
          "y": 165
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 180,
          "y": 65
        },
        {
          "x": 235,
          "y": 65
        },
        {
          "x": 235,
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
          "x": 155,
          "y": 120
        },
        {
          "x": 155,
          "y": 165
        },
        {
          "x": 150,
          "y": 165
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 115,
          "y": 120
        },
        {
          "x": 120,
          "y": 120
        },
        {
          "x": 120,
          "y": 165
        },
        {
          "x": 115,
          "y": 165
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 0,
          "y": 165
        },
        {
          "x": 60,
          "y": 165
        },
        {
          "x": 60,
          "y": 160
        },
        {
          "x": 0,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 80,
          "y": 165
        },
        {
          "x": 120,
          "y": 165
        },
        {
          "x": 120,
          "y": 160
        },
        {
          "x": 80,
          "y": 160
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 115,
          "y": 35
        },
        {
          "x": 120,
          "y": 35
        },
        {
          "x": 120,
          "y": 100
        },
        {
          "x": 115,
          "y": 100
        }
      ]
    },
    {
      "vertices": [
        {
          "x": 0,
          "y": 195
        },
        {
          "x": 380,
          "y": 195
        },
        {
          "x": 380,
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
          "x": 0,
          "y": 40
        },
        {
          "x": 70,
          "y": 40
        },
        {
          "x": 70,
          "y": 35
        },
        {
          "x": 0,
          "y": 35
        }
      ]
    }
  ],
  "doors": [
    {
      "status": "closed",
      "vertices": [
        {
          "x": 60,
          "y": 165
        },
        {
          "x": 80,
          "y": 165
        },
        {
          "x": 80,
          "y": 160
        },
        {
          "x": 60,
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
          "x": 265,
          "y": 90
        },
        {
          "x": 265,
          "y": 110
        }
      ]
    }
  ],
  "items": [
    {
      "type": "keycard",
      "position": {
        "x": 205,
        "y": 145
      }
    },
    {
      "type": "keycard",
      "position": {
        "x": 45,
        "y": 125
      }
    }
  ]
}
''';
}
