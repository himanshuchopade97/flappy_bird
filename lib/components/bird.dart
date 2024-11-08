import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks{

  //INITIALIZE bird position and size
  Bird() : super(position: Vector2(birdStartX, birdStartY), size: Vector2(birdWidth, birdHeight));

  //physical world property
  double velocity = 0;


  //LOAD
  @override
  FutureOr<void> onLoad() async {
    //load bird sprite image
    sprite = await Sprite.load('bird.png');
  
    //add hit box
    add(RectangleHitbox());
  }

  //JUMP /FLAP

  void flap() {
    velocity = jumpStrength;
  }

  //UPDATE -> every secondd
  @override
  void update(double dt) {
    //apply gravity
    velocity += gravity * dt;

    //update bird's position based on current velocity
    position.y += velocity * dt;
  }

  // COLLISION - with other object
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    //check if bird collides with ground
    if (other is Ground){
      (parent as FlappyBirdGame).gameOver();
    }
    if (other is Pipe){
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
