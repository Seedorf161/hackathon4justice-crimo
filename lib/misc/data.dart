class Data {
  List<Map<String, String>> courtHouses = [
    {
      "id": "1111",
      "name": "Igbosere magistrate court",
    },
    {
      "id": "2222",
      "name": "Igando customary court",
    },
    {
      "id": "3333",
      "name": "Sharia court",
    },
  ];

  List<Map<String, String>> highCourtHouses = [
    {
      "id": "11111",
      "name": "Ikeja High court",
    },
    {
      "id": "22221",
      "name": "High court of Lagos",
    },
    {
      "id": "33331",
      "name": "Federal high court",
    },
  ];

  List<Map<String, dynamic>> judges = [
    {
      "id": "111",
      "courtHouse": "1111",
      "judges": ["Barrister Williams", "Barrister Jane Doe", "Barrister Terry"],
    },
    {
      "id": "222",
      "courtHouse": "2222",
      "judges": ["Barrister Ade", "Barrister Wole", "Barrister Martins"],
    },
  ];

  List<Map<String, String>> policeStations = [
    {
      "id": "1111",
      "name": "Ikoyi Police Station",
    },
    {
      "id": "2222",
      "name": "Orile Police Station",
    },
    {
      "id": "3333",
      "name": "Ojo Police Station",
    },
  ];
}
