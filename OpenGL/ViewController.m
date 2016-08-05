//
//  ViewController.m
//  OpenGL
//
//  Created by KuiYin on 16/8/5.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKViewController.h>
#import <GLKit/GLKit.h>
@interface ViewController ()

@property (strong, nonatomic) EAGLContext *context;

@property (strong, nonatomic) GLKBaseEffect *effect;//着色效果

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    顶点X、顶点Y，顶点Z、法线X、法线Y、法线Z、纹理S、纹理T。
//    顶点位置用于确定在什么地方显示，法线用于光照模型计算，纹理则用在贴图中。
//    一般约定为“顶点以逆时针次序出现在屏幕上的面”为“正面”。
//    世界坐标是OpenGL中用来描述场景的坐标，Z+轴垂直屏幕向外，X+从左到右，Y+轴从下到上，是右手笛卡尔坐标系统。我们用这个坐标系来描述物体及光源的位置。
    GLfloat squareVertexData[48] = {
        0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
        -0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
        0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
        0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
        -0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
        -0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    };
    
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:_context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f);
    
    // 声明一个缓冲区的标识（GLuint类型）让OpenGL自动分配一个缓冲区并且返回这个标识的值.绑定这个缓冲区到当前“Context”.最后，将我们前面预先定义的顶点数据“squareVertexData”复制进这个缓冲区中。
    // 注：参数“GL_STATIC_DRAW”，它表示此缓冲区内容只能被修改一次，但可以无限次读取。
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    //将缓冲区的数据复制进能用顶点属性中
    //1.O激活顶点
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4 * 8, (char *)NULL + 0);
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_TRUE, 4*8, (char*)NULL + 12 );
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4*8, (char*)NULL+24);
    
}

- (void)update {
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
