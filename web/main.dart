// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';

num lastFrame = 0.0; // Time count for animation deltas
final int fps = 60; // Frames per second
final double interval = 1000 / fps; // Animation interval

PartyTile pt;

void main() {
  DivElement div = querySelector('#output');
  pt = new PartyTile(div, 100);
  window.animationFrame.then(loop);
}

/// Recursive loop for animation
void loop(num delta) {
  if (delta - lastFrame > interval) {
    pt.animate();
    lastFrame = delta;
  }
  window.animationFrame.then(loop);
}

class PartyTile {
  DivElement div;
  int r;
  int g;
  int b;
  double time;

  PartyTile(DivElement div, int precision) {
    this.div = div;
    for (int i = 0; i < precision; i++) {
      DivElement divEl = new DivElement()
        ..style.float = 'left'
        ..style.height = '100%'
        ..style.width = '${100.0 / precision}%';
      div.children.add(divEl);
    }
    r = 0;
    g = 0;
    b = 0;
    time = 0.0;
  }

  void animate() {
    double dr = 1.3;
    double dg = 4.25;
    double db = 3.333;

    r = (255 * ((sin(time / dr) + 1) / 2)).round();
    g = (255 * ((sin(time / dg) + 1) / 2)).round();
    b = (255 * ((sin(time / db) + 1) / 2)).round();

    //print('rgb($r,$g,$b)');

    //div.style.backgroundColor = 'rgb($r,$g,$b)';

    for (int i = div.children.length - 1; i > 0; i--) {
      div.children.elementAt(i).style.backgroundColor =
          div.children.elementAt(i - 1).style.backgroundColor;
    }

    div.children.elementAt(0).style.backgroundColor = 'rgb($r,$g,$b)';

    time += 0.1 % (2 * PI);
  }
}
