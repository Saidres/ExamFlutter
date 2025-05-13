import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';
import 'package:application_medicines/medication_controller.dart';
import 'package:application_medicines/medication.dart';
import 'package:application_medicines/screen/medication_detail_screen.dart';

class MedicationListScreen extends StatelessWidget {
  final MedicationController medicationController =
      Get.find<MedicationController>();

  final RxString searchQuery = ''.obs; // Variable para manejar la búsqueda

  MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Medicamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                searchQuery.value = value; // Actualizar la búsqueda
              },
              decoration: const InputDecoration(
                labelText: 'Buscar Medicamento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                // Filtrar medicamentos según la búsqueda
                final filteredMedications = medicationController.medications
                    .where((medication) => medication.name
                        .toLowerCase()
                        .contains(searchQuery.value.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: filteredMedications.length,
                  itemBuilder: (context, index) {
                    final medication = filteredMedications[index];
                    return MedicationCard(medication: medication);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-medication'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(medication.name),
        subtitle: Text('Dosis: ${medication.dosage}'),
        onTap: () {
          Get.to(() => MedicationDetailScreen(medication: medication));
        },
      ),
    );
  }
}