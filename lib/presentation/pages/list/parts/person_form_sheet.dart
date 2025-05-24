part of '../list_page.dart';

class PersonFormSheet extends StatelessWidget {
  final Person? person;
  final VoidCallback? onSaved;

  const PersonFormSheet({super.key, this.person, this.onSaved});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final personController = Get.find<PersonController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      personController.setEditMode(person != null);
      if (person != null) {
        _populateForm(personController, person!);
      }
    });

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, -5.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(
                          personController.isEditMode.value
                              ? 'Edit Person'
                              : 'Add Person',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              Divider(height: 1),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: personController.nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name *',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        TextFormField(
                          controller: personController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email *',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!_isValidEmail(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        TextFormField(
                          controller: personController.handphoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Phone Number *',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone number is required';
                            }
                            if (!_isValidPhone(value.trim())) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        TextFormField(
                          controller: personController.addressController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Address *',
                            prefixIcon: Icon(Icons.home),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Address is required';
                            }
                            if (value.trim().length < 10) {
                              return 'Please enter a complete address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        Obx(
                          () => TextFormField(
                            controller: personController.passwordController,
                            obscureText: personController.obscurePassword.value,
                            decoration: InputDecoration(
                              labelText:
                                  personController.isEditMode.value
                                      ? 'New Password (leave empty to keep current)'
                                      : 'Password *',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  personController.obscurePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                    personController.togglePasswordVisibility,
                              ),
                            ),
                            validator: (value) {
                              if (!personController.isEditMode.value) {
                                // For new person, password is required
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                              } else {
                                // For edit mode, only validate if password is provided
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 16),

                        Obx(
                          () => TextFormField(
                            controller:
                                personController.confirmPasswordController,
                            obscureText:
                                personController.obscureConfirmPassword.value,
                            decoration: InputDecoration(
                              labelText:
                                  personController.isEditMode.value
                                      ? 'Confirm New Password'
                                      : 'Confirm Password *',
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  personController.obscureConfirmPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                    personController
                                        .toggleConfirmPasswordVisibility,
                              ),
                            ),
                            validator: (value) {
                              if (!personController.isEditMode.value) {
                                // For new person, confirmation is required
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value !=
                                    personController.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                              } else {
                                // For edit mode, only validate if password is provided
                                if (personController
                                    .passwordController
                                    .text
                                    .isNotEmpty) {
                                  if (value !=
                                      personController
                                          .passwordController
                                          .text) {
                                    return 'Passwords do not match';
                                  }
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Obx(
                            () => ElevatedButton(
                              onPressed:
                                  personController.isLoading.value
                                      ? null
                                      : () => _savePerson(
                                        formKey,
                                        personController,
                                        context,
                                        person,
                                        onSaved,
                                      ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child:
                                  personController.isLoading.value
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            personController.isEditMode.value
                                                ? 'Updating...'
                                                : 'Saving...',
                                          ),
                                        ],
                                      )
                                      : Text(
                                        personController.isEditMode.value
                                            ? 'Update Person'
                                            : 'Save Person',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Cancel Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Obx(
                            () => OutlinedButton(
                              onPressed:
                                  personController.isLoading.value
                                      ? null
                                      : () => Navigator.of(context).pop(),
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _populateForm(PersonController personController, Person person) {
    personController.nameController.text = person.name ?? '';
    personController.emailController.text = person.email ?? '';
    personController.handphoneController.text = person.handphone ?? '';
    personController.addressController.text = person.address ?? '';
  }

  String _encryptPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9+\-\s()]+$').hasMatch(phone) && phone.length >= 8;
  }

  Future<void> _savePerson(
    GlobalKey<FormState> formKey,
    PersonController personController,
    BuildContext context,
    Person? person,
    VoidCallback? onSaved,
  ) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    personController.setLoading(true);

    try {
      String? encryptedPassword;

      if (!personController.isEditMode.value ||
          personController.passwordController.text.isNotEmpty) {
        encryptedPassword = _encryptPassword(
          personController.passwordController.text,
        );
      } else {
        encryptedPassword = person!.password;
      }

      final personToSave = Person(
        id:
            personController.isEditMode.value
                ? person!.id
                : DateTime.now().millisecondsSinceEpoch,
        name: personController.nameController.text.trim(),
        email: personController.emailController.text.trim(),
        handphone: personController.handphoneController.text.trim(),
        address: personController.addressController.text.trim(),
        password: encryptedPassword,
      );

      await personController.savePerson(personToSave);

      String snackBarTitle = '';

      if (personController.isError) {
        snackBarTitle =
            personController.isEditMode.value ? 'Update Failed' : 'Save Failed';
      } else {
        onSaved?.call();

        if (context.mounted) {
          Navigator.of(context).pop();
        }

        snackBarTitle =
            personController.isEditMode.value
                ? 'Person updated successfully'
                : 'Person added successfully';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackBarTitle),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      personController.setLoading(false);
    }
  }
}
