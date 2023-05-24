import 'package:flutter/material.dart';
import 'package:medicine_app/dbmanager.dart';
import 'package:medicine_app/medicine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBmanager dBmanager = DBmanager();

  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _dosageAmountController = TextEditingController();
  final TextEditingController _medicineTypeController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  late Medicine medicine;

  late List<Medicine>? medicineList;
  late int updateIndex;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take your medicines!'),
      ),
      body: FutureBuilder(
        future: dBmanager.getMedicineList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            medicineList = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: medicineList == null ? 0 : medicineList!.length,
              itemBuilder: (BuildContext context, int index) {
                Medicine medicine = medicineList![index];
                return Card(
                  color: const Color.fromARGB(255, 226, 225, 234),
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Medicine Name : ${medicine.medicineName}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Frequeny : ${medicine.frequency}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Dosage Amount : ${medicine.dosageAmount}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Medicine Type : ${medicine.medicineType}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Instructions : ${medicine.instructions}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                openDialogueBox(context);
                                medicine = medicine;
                                updateIndex = index;
                              },
                              icon: const Icon(Icons.edit,
                                  color: Colors.deepPurple),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: () {
                                dBmanager.deleteMedicine(medicine.id);
                                setState(() {
                                  medicineList!.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete_sweep,
                                  color: Colors.deepPurple),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          //return const CircularProgressIndicator();
          return const Padding(
            padding: EdgeInsets.fromLTRB(100, 50, 20, 50),
            child: Text(
              'Add some medicines',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.deepPurple,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogueBox(context);
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        splashColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Add Medicine Details',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 225, 234),
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _medicineNameController,
                      decoration: const InputDecoration(
                        labelText: 'Medicine Name',
                        hintText: 'The name on the package',
                      ),
                    ),
                    TextField(
                      controller: _frequencyController,
                      decoration: const InputDecoration(
                        labelText: 'Frequency',
                        hintText: 'number of medicine intake in a day',
                      ),
                    ),
                    TextField(
                      controller: _dosageAmountController,
                      decoration: const InputDecoration(
                        labelText: 'Dosage',
                        hintText: 'ex: one tabletor half tablet etc.',
                      ),
                    ),
                    TextField(
                      controller: _medicineTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Medicine Type',
                        hintText: 'ex: tablet/ capsule/ syrup/ powder',
                      ),
                    ),
                    TextField(
                      controller: _instructionsController,
                      decoration: const InputDecoration(
                        labelText: 'Instructions',
                        hintText: 'ex: after meals/ empty stomach etc.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  submitAction(context);
                  refreshList();
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  submitAction(BuildContext context) {
    if (medicine == null) {
      Medicine md = Medicine(
        medicineName: _medicineNameController.text,
        frequency: _frequencyController.text,
        dosageAmount: _dosageAmountController.text,
        medicineType: _medicineTypeController.text,
        instructions: _instructionsController.text,
      );
      dBmanager.insertMedicine(md).then((value) => {
            _medicineNameController.clear(),
            _frequencyController.clear(),
            _dosageAmountController.clear(),
            _medicineTypeController.clear(),
            _instructionsController.clear(),
          });
    } else {
      medicine.medicineName = _medicineNameController.text;
      medicine.frequency = _frequencyController.text;
      medicine.dosageAmount = _dosageAmountController.text;
      medicine.medicineType = _medicineTypeController.text;
      medicine.instructions = _instructionsController.text;

      dBmanager.updateMedicine(medicine).then(
            (value) => {
              _medicineNameController.clear(),
              _frequencyController.clear(),
              _dosageAmountController.clear(),
              _medicineTypeController.clear(),
              _instructionsController.clear(),
              setState(
                () {
                  medicineList![updateIndex].medicineName =
                      _medicineNameController.text;
                  medicineList![updateIndex].frequency =
                      _frequencyController.text;
                  medicineList![updateIndex].dosageAmount =
                      _dosageAmountController.text;
                  medicineList![updateIndex].medicineType =
                      _medicineTypeController.text;
                  medicineList![updateIndex].instructions =
                      _instructionsController.text;
                },
              ),
              //medicine = null;
            },
          );
    }
  }
}
