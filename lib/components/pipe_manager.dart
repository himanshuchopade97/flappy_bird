import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  //UPDATE EVERY SECOND
  //WE WILL SPAWN CONTINUOSLY

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    //dt is in seconds
    //generate new pipe at given interval
    pipeSpawnTimer += dt;
 

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;


    //CALCULATE PIPE HEIGHT

    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    //height of bottom pipe -> randomly select betwee min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height of top pipe
    final double topPipeHeight = screenHeight - bottomPipeHeight - pipeGap;

    //CREATE BOTTOM PIPE
    final bottomPipe = Pipe(
      //position
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),

      //size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    //CREATE TOP PIPE
    final topPipe = Pipe(
      //position
      Vector2(gameRef.size.x, 0),

      //size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    //add both pipe to game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
