import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_mail/open_mail.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckEmailScreen extends StatelessWidget {
  final String email;

  const CheckEmailScreen({super.key, required this.email});

  void openEmailApp(BuildContext context) async {
    final result = await OpenMail.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No se encontró una aplicación de correo."),
        ),
      );

      final Uri gmail = Uri.parse("https://mail.google.com");

      if (await canLaunchUrl(gmail)) {
        await launchUrl(gmail, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar contraseña"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Lottie.asset(
                    'assets/lottie/email_code.json',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: "Hemos enviado un enlace de verificacion a ",
                      ),
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Revisa tu bandeja de entrada o spam.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    openEmailApp(context);
                  },
                  child: const Text("Abrir correo"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
