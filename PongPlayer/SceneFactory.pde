class SceneFactory {
  
  color CreateScene1() {
    bricks.add(brickFactory.CreateQuad(460, 550, 745, 550, 770, 600, 485, 600, 0, color(128, 128, 128, 240)));
    bricks.add(brickFactory.CreateQuad(440, 250, 1200, 250, 1310, 430, 550, 430, 1, color(0, 0, 0, 240)));
    bricks.add(brickFactory.CreateQuad(545, 450, 595, 450, 695, 630, 645, 630, 2, color(255, 255, 153, 150)));
    bricks.add(brickFactory.CreateCircle(900, 250, 150, 3, color(255, 0, 0, 170)));
    bricks.add(brickFactory.CreateCircle(650, 550, 75, 4, color(255, 0, 0, 170)));
    bricks.add(brickFactory.CreateQuad(710, 100, 810, 100, 1050, 500, 940, 500, 5, color(255, 255, 0, 160)));
    bricks.add(brickFactory.CreateQuad(590, 565, 700, 565, 635, 700, 525, 700, 6, color(0, 0, 0, 180)));
    bricks.add(brickFactory.CreateQuad(700, 300, 1065, 300, 895, 660, 530, 660, 7, color(255, 255, 255, 160)));
    
    return color(205, 133, 63);
  }
  
  color CreateScene2() {
    int s = 500;
    int o = 400;
    
    bricks.add(brickFactory.CreateQuad(100+s, 30+o, 90+s, 20+o, 80+s, 30+o, 90+s, 40+o, 8, color(13, 86, 41, 240)));
    bricks.add(brickFactory.CreateQuad(110+s, 20+o, 130+s, 10+o, 155+s, 50+o, 135+s, 60+o, 9, color(203, 38, 42, 240)));
    bricks.add(brickFactory.CreateQuad(200+s, 50+o, 230+s, 60+o, 215+s, 130+o, 185+s, 120+o, 10, color(203, 38, 42, 240)));
    bricks.add(brickFactory.CreateQuad(300+s, 0+o, 310+s, 0+o, 260+s, 250+o, 250+s, 250+o, 11, color(106, 69, 51, 240)));
    bricks.add(brickFactory.CreateQuad(100+s, 260+o, 100+s, 190+o, 200+s, 180+o, 200+s, 260+o, 12, color(211, 184, 43, 240)));
    bricks.add(brickFactory.CreateCircle(380+s,100+o,50, 13, color(196, 178, 50, 170)));
    
    bricks.add(brickFactory.CreateQuad(450+s, 0+o, 470+s, 0+o, 560+s, 140+o, 540+s, 145+o, 14, color(46, 110, 58, 240)));
    bricks.add(brickFactory.CreateQuad(790+s, 30+o, 785+s, 120+o, 680+s, 120+o, 680+s, 25+o, 15, color(203, 38, 42, 240)));
    bricks.add(brickFactory.CreateQuad(785+s, 135+o, 780+s, 225+o, 680+s, 220+o, 685+s, 145+o, 16, color(205, 108, 40, 240)));
    bricks.add(brickFactory.CreateQuad(450+s, 400+o, 400+s, 400+o, 560+s, 190+o, 650+s, 215+o, 17, color(0, 0, 0, 240)));
    bricks.add(brickFactory.CreateQuad(510+s, 220+o, 540+s, 230+o, 530+s, 260+o, 500+s, 260+o, 18, color(80, 88, 109, 240)));    
    bricks.add(brickFactory.CreateQuad(505+s, 240+o, 460+s, 230+o, 455+s, 255+o, 500+s, 265+o, 19, color(203, 38, 42, 240)));  
    
    return color(205, 133, 63);
  }
  
  color CreateScene3() {
    bricks.add(brickFactory.CreateQuad(535, 0, 620, 0, 940, 800, 850, 800, 20, color(255, 255, 255, 50)));
    bricks.add(brickFactory.CreateQuad(500, 800, 1030, 560, 1045, 640, 700, 800, 21, color(160, 15, 15, 50)));
    bricks.add(brickFactory.CreateCircle(860, 590, 150, 22, color(0, 0, 0, 0)));
    bricks.add(brickFactory.CreateCircle(749, 430, 90, 23, color(198, 20, 14)));
    bricks.add(brickFactory.CreateTriangle(550, 375, 630, 320, 710, 775, 24, color(0)));
    bricks.add(brickFactory.CreateQuad(400, 410, 410, 410, 880, 600, 870, 600, 25, color(52, 142, 97)));
    bricks.add(brickFactory.CreateQuad(620, 630, 870, 410, 880, 410, 630, 630, 26, color(52, 142, 97)));
    
    return color(205, 133, 63);
  }
  
  color CreateScene4() {
    bricks.add(brickFactory.CreateQuad(306, 775, 617, 265, 617, 269, 306, 781, 27, color(#403D5C)));
    bricks.add(brickFactory.CreateQuad(422, 494, 622, 367, 622, 371, 422, 498, 28, color(#C7740A)));
    bricks.add(brickFactory.CreateQuad(288, 766, 345, 803, 345, 807, 288, 770, 29, color(#AA2810)));
    bricks.add(brickFactory.CreateQuad(427, 432, 480, 435, 480, 439, 427, 436, 30, color(#AA2810)));
    bricks.add(brickFactory.CreateQuad(180, 482, 235, 460, 235, 464, 180, 486, 31, color(#AA2810)));
    bricks.add(brickFactory.CreateQuad(43, 241, 133, 240, 133, 244, 43, 245, 32, color(#AA2810)));
    bricks.add(brickFactory.CreateQuad(87, 294, 82, 217, 82, 221, 87, 298, 33, color(#AA2810)));
    bricks.add(brickFactory.CreateQuad(71, 127, 210, 465, 210, 469, 71, 131, 34, color(#AA2810)));
    
    bricks.add(brickFactory.CreateTriangle(310, 243, 403, 245, 372, 387, 35, color(#EB7201)));
    
    bricks.add(brickFactory.CreateQuad(338, 371, 584, 436, 584, 440, 338, 375, 36, color(255, 255, 255, 160)));
    
    bricks.add(brickFactory.CreateQuad(258, 779, 283, 786, 277, 816, 257, 812, 37, color(#10284E)));
    bricks.add(brickFactory.CreateQuad(288, 638, 300, 638, 301, 648, 288, 650, 38, color(#403C77)));
    bricks.add(brickFactory.CreateQuad(365, 341, 455, 305, 467, 333, 371, 368, 39, color(0)));
    bricks.add(brickFactory.CreateQuad(89, 400, 648, 188, 655, 206, 96, 417, 40, color(#BD1304)));
    bricks.add(brickFactory.CreateQuad(540, 169, 568, 159, 609, 268, 582, 280, 41, color(#BD1304)));
    bricks.add(brickFactory.CreateQuad(168, 249, 419, 244, 418, 177, 167, 209, 42, color(#AA0C01)));
    bricks.add(brickFactory.CreateQuad(224, 202, 213, 130, 501, 91, 511, 165, 43, color(#101103)));
    bricks.add(brickFactory.CreateQuad(314, 120, 305, 31, 397, 26, 406, 105, 44, color(#101103)));
    bricks.add(brickFactory.CreateQuad(401, 79, 538, 59, 540, 89, 406, 107, 45, color(#CA3904)));
    
    return color(70);
  }
  
  color CreateScene5() {
    PImage textureImage = loadImage("tex_01.png");
    
    bricks.add(brickFactory.CreateCircle(400, 600, 100, 46, color(255, 214, 51)));
    
    bricks.add(brickFactory.CreateQuad(380, 50, 500, 30, 520, 250, 400, 230, 47, color(0)));
    bricks.add(brickFactory.CreateQuad(540, 100, 660, 95, 665, 210, 545, 215, 48, color(0)));
    bricks.add(brickFactory.CreateQuad(710, 20, 820, 20, 830, 280, 720, 283, 49, color(0)));
    bricks.add(brickFactory.CreateQuad(880, 130, 930, 60, 960, 95, 910, 150, 50, color(0)));
    
    bricks.add(brickFactory.CreateQuad(360, 420, 510, 280, 640, 500, 500, 600, 51, textureImage));
    bricks.add(brickFactory.CreateQuad(600, 410, 690, 260, 790, 360, 660, 490, 52, color(0)));
    bricks.add(brickFactory.CreateQuad(760, 410, 810, 410, 810, 460, 760, 460, 53, color(0)));
    bricks.add(brickFactory.CreateQuad(650, 500, 700, 465, 750, 630, 720, 640, 54, color(0)));
    
    bricks.add(brickFactory.CreateQuad(380, 680, 520, 690, 510, 750, 375, 740, 55, color(0)));
    bricks.add(brickFactory.CreateQuad(480, 630, 560, 570, 600, 710, 570, 760, 56, color(0)));
    bricks.add(brickFactory.CreateQuad(650, 720, 670, 640, 760, 660, 740, 730, 57, color(0)));
    bricks.add(brickFactory.CreateQuad(800, 700, 840, 270, 920, 290, 880, 720, 58, color(0)));
    bricks.add(brickFactory.CreateQuad(890, 705, 940, 708, 940, 750, 887, 750, 59, color(0)));
    
    return color(70);
  }
  
  color CreateScene6 () {
    color[] colors = new color[2];
    colors[0] = color(82, 104, 159);
    colors[1] = color(172, 220, 221);
    
    for (int i = 0; i < 11; i++) {
      for (int j = 0; j < 7; j++) { 
        int rx = (int) random(120, 130);
        int ry1 = (int) random(120, 130);
        int ry2 = (int) random(120, 140);
        //if(i % 2 == 0) {
          //bricks.add(brickFactory.CreateQuad(20+(i*rx), 100 +(j*ry1), 40+(i*rx), 20 +(j*ry1), 80+(i*rx), 20 +(j*ry1), 100+(i*rx), 100 +(j*ry2), brickId, colors[int(random(colors.length))]));
        //}
        //else {
          //bricks.add(brickFactory.CreateQuad(20+(i*rx), 100 +(j*ry1), 40+(i*rx), 20 +(j*ry1), 80+(i*rx), 20 +(j*ry1), 100+(i*rx), 100 +(j*ry2), brickId, color(172, 220, 221)));
       //}
      } 
    }
    
    return color(205, 133, 63); 
  }
  
  color CreateScene100() {
    //bricks.add(brickFactory.CreateQuad(400, 400, 500, 300, 600, 400, 500, 500, brickId, color(0)));
    
    return color(70);
  }
}
