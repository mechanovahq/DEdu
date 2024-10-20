import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor DEDU_USERS {

  /**
   * Types
   */

  // The type of a user identifier.
  public type userId = Nat32;

  // The type of a user.
  public type user = {
    name : Text;
  };

  /**
   * Application State
   */

  // The next available user identifier.
  private stable var next : userId = 0;

  // The user data store.
  private stable var users : Trie.Trie<userId, user> = Trie.empty();

  /**
   * High-Level API
   */

  // Create a user.
  public func create(user : user) : async userId {
    let userId = next;
    next += 1;
    users := Trie.replace(
      users,
      key(userId),
      Nat32.equal,
      ?user,
    ).0;
    return userId;
  };

  // Read a user.
  public query func read(userId : userId) : async ?user {
    let result = Trie.find(users, key(userId), Nat32.equal);
    return result;
  };

  // Update a user.
  public func update(userId : userId, user : user) : async Bool {
    let result = Trie.find(users, key(userId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      users := Trie.replace(
        users,
        key(userId),
        Nat32.equal,
        ?user,
      ).0;
    };
    return exists;
  };

  // Delete a user.
  public func delete(userId : userId) : async Bool {
    let result = Trie.find(users, key(userId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      users := Trie.replace(
        users,
        key(userId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Utilities
   */

  // Create a trie key from a user identifier.
  private func key(x : userId) : Trie.Key<userId> {
    return { hash = x; key = x };
  };
};
