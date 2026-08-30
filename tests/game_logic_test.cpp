#include <assert.h>
#include <stdint.h>

#include "../ch32v003_arduino_game/game_logic.h"

using namespace GameLogic;

void testRectangleOverlap() {
  assert(overlaps(0, 0, 2, 2, 1, 1, 2, 2));
  assert(!overlaps(0, 0, 2, 2, 2, 0, 2, 2));
  assert(!overlaps(0, 0, 2, 2, 0, 2, 2, 2));
}

void testMovementIsClampedAndOpposingButtonsCancel() {
  State state = {1, 0, 8, 0};

  movePlayer(state, true, false);
  assert(state.playerX == 0);

  state.playerX = SCREEN_WIDTH - PLAYER_WIDTH - 1;
  movePlayer(state, false, true);
  assert(state.playerX == SCREEN_WIDTH - PLAYER_WIDTH);

  movePlayer(state, true, true);
  assert(state.playerX == SCREEN_WIDTH - PLAYER_WIDTH);
}

void testSpawnCanUseBothScreenEdges() {
  assert(obstacleSpawnX(0) == 0);
  assert(obstacleSpawnX(SCREEN_WIDTH - OBSTACLE_SIZE) == 122);
  assert(obstacleSpawnX(123) == 0);
}

void testDifficultyHasACap() {
  assert(obstacleSpeed(0) == 2);
  assert(obstacleSpeed(8) == 3);
  assert(obstacleSpeed(24) == 5);
  assert(obstacleSpeed(UINT16_MAX) == 5);
}

void testScoringAndScoreSaturation() {
  State state = {100, 0, 63, 7};

  assert(stepObstacle(state) == STEP_SCORED);
  assert(state.score == 8);

  state.obstacleY = 63;
  state.score = UINT16_MAX;
  assert(stepObstacle(state) == STEP_SCORED);
  assert(state.score == UINT16_MAX);
}

void testFastObstacleCannotTunnelThroughPlayer() {
  State state = {50, 50, 47, 24};

  assert(obstacleSpeed(state.score) == 5);
  assert(stepObstacle(state) == STEP_HIT);
  assert(state.obstacleY == 52);
}

void testResetRestoresInitialState() {
  State state = {3, 4, 5, 99};

  resetGame(state, 122);
  assert(state.playerX == 58);
  assert(state.obstacleX == 122);
  assert(state.obstacleY == OBSTACLE_START_Y);
  assert(state.score == 0);
}

int main() {
  testRectangleOverlap();
  testMovementIsClampedAndOpposingButtonsCancel();
  testSpawnCanUseBothScreenEdges();
  testDifficultyHasACap();
  testScoringAndScoreSaturation();
  testFastObstacleCannotTunnelThroughPlayer();
  testResetRestoresInitialState();
}
