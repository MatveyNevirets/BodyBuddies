import 'package:body_buddies/features/chats/domain/entity/fake_user_entity.dart';

import 'entity/chat.dart';

class FakeChatsDatabase {
  List<FakeUser> friends = [
    FakeUser(name: "add", avatar_path: "lib/assets/images/Check.png"),
    FakeUser(name: "Качок2011", avatar_path: "lib/assets/images/WorkoutsCardBackground.png"),
    FakeUser(
        name: "Пабло",
        avatar_path: "lib/assets/images/bench_press_calculator_background.png"),
    FakeUser(name: "Качок2011", avatar_path: "lib/assets/images/yellow.png"),
    FakeUser(
        name: "Пабло",
        avatar_path: "lib/assets/images/water_cup.jpg"),
    FakeUser(
        name: "Пабло",
        avatar_path: "lib/assets/images/CalendarIcon.png"),
    FakeUser(name: "Качок2011", avatar_path: "lib/assets/images/apple.png"),
    FakeUser(
        name: "Пабло",
        avatar_path: "lib/assets/images/X.png"),
  ];

  List<Chat> chats = [
    Chat(),
    Chat(),
    Chat(),
    Chat(),
    Chat(),
    Chat(),
    Chat(),
    Chat(),
  ];
}
