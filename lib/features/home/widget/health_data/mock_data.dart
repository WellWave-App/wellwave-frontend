final List<Map<String, dynamic>> mockData = [
  {'date': '2-11-2024', 'value': 80},
  {'date': '3-11-2024', 'value': 80},
  {'date': '4-11-2024', 'value': 880},
  {'date': '5-11-2024', 'value': 300},
  {'date': '6-11-2024', 'value': 1050},
  {'date': '7-11-2024', 'value': 2800},
  {'date': '8-11-2024', 'value': 280},
  {'date': '9-11-2024', 'value': 300},
  {'date': '10-11-2024', 'value': 320},
  {'date': '11-11-2024', 'value': 880},
  {'date': '12-11-2024', 'value': 300},
  {'date': '13-11-2024', 'value': 150},
  {'date': '14-11-2024', 'value': 280},
  {'date': '15-11-2024', 'value': 280},
  {'date': '16-11-2024', 'value': 300},
  {'date': '17-11-2024', 'value': 320},
  {'date': '18-11-2024', 'value': 800},
  {'date': '19-11-2024', 'value': 480},
  {'date': '20-11-2024', 'value': 180},
  {'date': '21-11-2024', 'value': 280},
  {'date': '22-11-2024', 'value': 250},
  {'date': '23-11-2024', 'value': 350},
  {'date': '24-11-2024', 'value': 390},
  {'date': '25-11-2024', 'value': 480},
  {'date': '26-11-2024', 'value': 150},
  {'date': '27-11-2024', 'value': 200},
  {'date': '28-11-2024', 'value': 250},
  {'date': '29-11-2024', 'value': 300},
  {'date': '30-11-2024', 'value': 320},
  {'date': '1-12-2024', 'value': 150},
  {'date': '2-12-2024', 'value': 200},
  {'date': '3-12-2024', 'value': 250},
  {'date': '4-12-2024', 'value': 300},
  {'date': '5-12-2024', 'value': 350},
  {'date': '6-12-2024', 'value': 400},
  {'date': '7-12-2024', 'value': 450},
  {'date': '8-12-2024', 'value': 500},
  {'date': '9-12-2024', 'value': 550},
  {'date': '10-12-2024', 'value': 600},
  {'date': '11-12-2024', 'value': 650},
  {'date': '12-12-2024', 'value': 700},
  {'date': '13-12-2024', 'value': 750},
  {'date': '14-12-2024', 'value': 800},
  {'date': '15-12-2024', 'value': 850},
  {'date': '16-12-2024', 'value': 900},
  {'date': '17-12-2024', 'value': 950},
  {'date': '18-12-2024', 'value': 1000},
  {'date': '19-12-2024', 'value': 1050},
  {'date': '20-12-2024', 'value': 1100},
  {'date': '21-12-2024', 'value': 1150},
  {'date': '22-12-2024', 'value': 1200},
  {'date': '23-12-2024', 'value': 1250},
  {'date': '24-12-2024', 'value': 1300},
  {'date': '25-12-2024', 'value': 1350},
  {'date': '26-12-2024', 'value': 1400},
  {'date': '27-12-2024', 'value': 1450},
  {'date': '28-12-2024', 'value': 1500},
  {'date': '29-12-2024', 'value': 1550},
  {'date': '30-12-2024', 'value': 1600},
  {'date': '31-12-2024', 'value': 1650},
  {'date': '1-1-2025', 'value': 1700},
  {'date': '2-1-2025', 'value': 1750},
  {'date': '3-1-2025', 'value': 1800},
  {'date': '4-1-2025', 'value': 1850},
  {'date': '5-1-2025', 'value': 1900},
  {'date': '6-1-2025', 'value': 1950},
  {'date': '7-1-2025', 'value': 2000},
  {'date': '8-1-2025', 'value': 2050},
  {'date': '9-1-2025', 'value': 2100},
  {'date': '10-1-2025', 'value': 2150},
  {'date': '11-1-2025', 'value': 2200},
  {'date': '12-1-2025', 'value': 2250},
  {'date': '13-1-2025', 'value': 2300},
  {'date': '14-1-2025', 'value': 2350},
  {'date': '15-1-2025', 'value': 2400},
  {'date': '16-1-2025', 'value': 2450},
  {'date': '17-1-2025', 'value': 2500},
  {'date': '18-1-2025', 'value': 2550},
  {'date': '19-1-2025', 'value': 2600},
  {'date': '20-1-2025', 'value': 2650},
  {'date': '21-1-2025', 'value': 2700},
  {'date': '22-1-2025', 'value': 2750},
  {'date': '23-1-2025', 'value': 2800},
  {'date': '24-1-2025', 'value': 2850},
  {'date': '25-1-2025', 'value': 2900},
  {'date': '26-1-2025', 'value': 2950},
  {'date': '27-1-2025', 'value': 3000},
  {'date': '28-1-2025', 'value': 3050},
  {'date': '29-1-2025', 'value': 3100},
  {'date': '30-1-2025', 'value': 3150},
  {'date': '31-1-2025', 'value': 3200},
  {'date': '1-2-2025', 'value': 3250},
  {'date': '2-2-2025', 'value': 3300},
  {'date': '3-2-2025', 'value': 3350},
  {'date': '4-2-2025', 'value': 3400},
  {'date': '5-2-2025', 'value': 3450},
  {'date': '6-2-2025', 'value': 3500},
  {'date': '7-2-2025', 'value': 3550},
  {'date': '8-2-2025', 'value': 3600},
  {'date': '9-2-2025', 'value': 3650},
  {'date': '10-2-2025', 'value': 3700},
  {'date': '11-2-2025', 'value': 3750},
  {'date': '12-2-2025', 'value': 3800},
  {'date': '13-2-2025', 'value': 3850},
  {'date': '14-2-2025', 'value': 3900},
  {'date': '15-2-2025', 'value': 3950},
  {'date': '16-2-2025', 'value': 4000},
  {'date': '17-2-2025', 'value': 4050},
  {'date': '18-2-2025', 'value': 4100},
  {'date': '19-2-2025', 'value': 4150},
  {'date': '20-2-2025', 'value': 4200},
  {'date': '21-2-2025', 'value': 4250},
  {'date': '22-2-2025', 'value': 4300},
  {'date': '23-2-2025', 'value': 4350},
  {'date': '24-2-2025', 'value': 4400},
  {'date': '25-2-2025', 'value': 4450},
  {'date': '26-2-2025', 'value': 4500},
  {'date': '27-2-2025', 'value': 4550},
  {'date': '28-2-2025', 'value': 4600},
  {'date': '1-3-2025', 'value': 4650},
  {'date': '2-3-2025', 'value': 4700},
  {'date': '3-3-2025', 'value': 4750},
  {'date': '4-3-2025', 'value': 4800},
  {'date': '5-3-2025', 'value': 4850},
  {'date': '6-3-2025', 'value': 4900},
  {'date': '7-3-2025', 'value': 4950},
  {'date': '8-3-2025', 'value': 5000},
  {'date': '9-3-2025', 'value': 5050},
  {'date': '10-3-2025', 'value': 5100},
  {'date': '11-3-2025', 'value': 5150},
  {'date': '12-3-2025', 'value': 5200},
  {'date': '13-3-2025', 'value': 5250},
  {'date': '14-3-2025', 'value': 5300},
  {'date': '15-3-2025', 'value': 5350},
  {'date': '16-3-2025', 'value': 5400},
  {'date': '17-3-2025', 'value': 5450},
  {'date': '18-3-2025', 'value': 5500},
  {'date': '19-3-2025', 'value': 5550},
  {'date': '20-3-2025', 'value': 5600},
  {'date': '21-3-2025', 'value': 5650},
  {'date': '22-3-2025', 'value': 5700},
  {'date': '23-3-2025', 'value': 5750},
  {'date': '24-3-2025', 'value': 5800},
  {'date': '25-3-2025', 'value': 5850},
  {'date': '26-3-2025', 'value': 5900},
  {'date': '27-3-2025', 'value': 5950},
  {'date': '28-3-2025', 'value': 6000},
  {'date': '29-3-2025', 'value': 6050},
  {'date': '30-3-2025', 'value': 6100},
  {'date': '31-3-2025', 'value': 6150},
  {'date': '1-4-2025', 'value': 6200},
  {'date': '2-4-2025', 'value': 6250},
  {'date': '3-4-2025', 'value': 6300},
  {'date': '4-4-2025', 'value': 6350}
];
