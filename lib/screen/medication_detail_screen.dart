import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/medication.dart';
import 'package:application_medicines/medication_controller.dart';

class MedicationDetailScreen extends StatelessWidget {
  final Medication medication;

  MedicationDetailScreen({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final MedicationController medicationController =
        Get.find<MedicationController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(medication.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dosis: ${medication.dosage}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Hora: ${medication.time.hour}:${medication.time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Mostrar modal de confirmación
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text(
                          '¿Estás seguro de que deseas eliminar este medicamento?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Eliminar el medicamento
                            await medicationController.deleteMedication(medication.id);
                            Navigator.of(context).pop(); // Cerrar el modal
                            Get.back(); // Regresar a la lista de medicamentos
                          },
                          child: const Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Eliminar Medicamento'),
            ),
          ],
        ),
      ),
    );
  }
}