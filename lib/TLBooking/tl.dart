import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
class TLBookingPage extends StatefulWidget {
  const TLBookingPage({super.key});

  @override
  State<TLBookingPage> createState() => _TLBookingPageState();
}
var user = FirebaseAuth.instance.currentUser!;

class _TLBookingPageState extends State<TLBookingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController machineController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    nameController.text = user.displayName!;
    emailController.text = user.email!;
    return super.initState();
  }
   Future<void> submitForm() async {
    const String apiUrl = 'http://localhost:3000/proceed_form';

    final Map<String, dynamic> formData = {
      "user": nameController.text,
      "email": emailController.text,
      "contact": mobileController.text,
      "machine": machineController.text,
      "utcStartTime": startTimeController.text,
      "utcEndTime": endTimeController.text,
      "info": descriptionController.text,
      "status": statusController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: formData,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Form submitted successfully"),
      ));
      // Form submission successfully
      print("Form submitted successfully");
      print(response.body); // You can process the response data here
    } else {
      // Form submission failed
      print("Form submission failed");
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Form Submission"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  
                    controller: nameController,
                    decoration: const InputDecoration(icon: Icon(Icons.person_2_outlined),
                        border: OutlineInputBorder(), labelText: 'Name')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: emailController,
                    decoration: const InputDecoration(icon: Icon(Icons.email_outlined),border: OutlineInputBorder(), labelText: 'Email')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: mobileController,
                    decoration: const InputDecoration(icon: Icon(Icons.phone),border: OutlineInputBorder(), labelText: 'Mobile')),
               const SizedBox(height: 15,),
                 TextField(
                  
                    controller: machineController,
                    decoration: const InputDecoration(icon: Icon(Icons.precision_manufacturing_sharp),border: OutlineInputBorder(), labelText: 'Machine')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: startTimeController,
                    decoration: const InputDecoration(icon: Icon(Icons.av_timer_outlined),border: OutlineInputBorder(), labelText: 'Start Time')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: endTimeController,
                    decoration: const InputDecoration(icon: Icon(Icons.av_timer_outlined),border: OutlineInputBorder(), labelText: 'End Time')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: descriptionController,
                    decoration: const InputDecoration(icon: Icon(Icons.info_outline),border: OutlineInputBorder(), labelText: 'Description')),
                const SizedBox(height: 15,),
                 TextField(
                  
                    controller: statusController,
                    decoration: const InputDecoration(icon: Icon(Icons.notes_outlined),border: OutlineInputBorder(), labelText: 'Status')),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    
                    icon: const Icon(Icons.done_outline),
                    label: const Text("Submit Form"),
                    onPressed: submitForm,
                               
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}