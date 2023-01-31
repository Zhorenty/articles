// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'model.g.dart';

class HiveModel {
  Future<Box<Future>>? userBox;

  void setup() {
    final userBox = Hive.openBox<User>('user_box');
    userBox.then((box) {
      box.listenable().addListener(() {
        print(box.values);
      });
    });
  }

  void doSome() async {
    final box = await userBox;
    final user = User(name: 'Zhora', age: 19);
    await box?.add(user as Future);

    // var box = await Hive.openBox<User>('userBox');
    // var petBox = await Hive.openBox<Pet>('petBox');
    // final pet = Pet(name: 'pushok');
    // petBox.add(pet);
    // final pets = HiveList(petBox, objects: [pet]);
    // var user = User(name: 'Zhora', age: 19, pets: pets);
    // await box.put('user', user);
    // print(box.values);

    // const secureStorage = FlutterSecureStorage();
    // final containsEncryptionKey = await secureStorage.containsKey(key: 'key');

    // if (!containsEncryptionKey) {
    //   final key = Hive.generateSecureKey();
    //   await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    // }

    // final key = await secureStorage.read(key: 'key');
    // var encryptionKey = base64Url.decode(key!);

    // final encryptedBox = await Hive.openBox<String>(
    //   'vaultBox',
    //   encryptionCipher: HiveAesCipher(encryptionKey),
    // );
    // encryptedBox.put('secret', 'Hive is cool');
    // print(encryptedBox.get('secret'));
  }
}

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  HiveList<Pet>? pets;

  User({required this.name, required this.age, this.pets});

  @override
  String toString() => 'Name: $name, Age: $age, pets: $pets';
}

@HiveType(typeId: 1)
class Pet extends HiveObject {
  @HiveField(0)
  String name;

  Pet({required this.name});

  @override
  String toString() => 'Name: $name';
}
