sealed class HomeDetailIntent {}

class NavigateToGamePlay extends HomeDetailIntent {}

class AddCharacter extends HomeDetailIntent {}

class RemoveCharacter extends HomeDetailIntent {
  final int index;

  RemoveCharacter(this.index);
}

class UpdateCharacterName extends HomeDetailIntent {
  final int index;
  final String name;

  UpdateCharacterName(this.index, this.name);
}

class UpdateCharacterImage extends HomeDetailIntent {
  final int index;
  final String imagePath;

  UpdateCharacterImage(this.index, this.imagePath);
}
