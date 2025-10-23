import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Todo Entity avec Freezed', () {
    test('devrait créer une instance Todo', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test Todo',
        description: 'Description test',
        isCompleted: false,
        createdAt: now,
      );

      expect(todo.id, '1');
      expect(todo.userId, 'user1');
      expect(todo.title, 'Test Todo');
      expect(todo.description, 'Description test');
      expect(todo.isCompleted, false);
      expect(todo.createdAt, now);
      expect(todo.completedAt, null);
    });

    test('devrait comparer deux Todos avec égalité', () {
      final now = DateTime.now();
      final todo1 = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test',
        isCompleted: false,
        createdAt: now,
      );

      final todo2 = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test',
        isCompleted: false,
        createdAt: now,
      );

      expect(todo1, equals(todo2));
    });

    test('devrait utiliser copyWith pour créer une copie modifiée', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test',
        isCompleted: false,
        createdAt: now,
      );

      final todoCompleted = todo.copyWith(isCompleted: true);

      expect(todoCompleted.id, todo.id);
      expect(todoCompleted.userId, todo.userId);
      expect(todoCompleted.title, todo.title);
      expect(todoCompleted.isCompleted, true);
      expect(todoCompleted.createdAt, todo.createdAt);
    });

    test('devrait avoir un hashCode cohérent', () {
      final now = DateTime.now();
      final todo1 = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test',
        isCompleted: false,
        createdAt: now,
      );

      final todo2 = Todo(
        id: '1',
        userId: 'user1',
        title: 'Test',
        isCompleted: false,
        createdAt: now,
      );

      expect(todo1.hashCode, equals(todo2.hashCode));
    });
  });

  group('User Entity avec Freezed', () {
    test('devrait créer une instance User', () {
      final now = DateTime.now();
      final user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: now,
      );

      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.createdAt, now);
    });

    test('devrait comparer deux Users avec égalité', () {
      final now = DateTime.now();
      final user1 = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        createdAt: now,
      );

      final user2 = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        createdAt: now,
      );

      expect(user1, equals(user2));
    });

    test('devrait utiliser copyWith pour créer une copie modifiée', () {
      final now = DateTime.now();
      final user = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: now,
      );

      final userUpdated = user.copyWith(name: 'Updated Name');

      expect(userUpdated.id, user.id);
      expect(userUpdated.email, user.email);
      expect(userUpdated.name, 'Updated Name');
      expect(userUpdated.createdAt, user.createdAt);
    });

    test('devrait avoir un hashCode cohérent', () {
      final now = DateTime.now();
      final user1 = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        createdAt: now,
      );

      final user2 = User(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        createdAt: now,
      );

      expect(user1.hashCode, equals(user2.hashCode));
    });
  });
}

