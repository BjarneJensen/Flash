package
{
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.renderers.*;
	import org.flintparticles.threeD.renderers.controllers.*;
	import org.flintparticles.threeD.zones.*;
	import resolumeCom.*;
	import resolumeCom.parameters.*;
	import resolumeCom.events.*;

	import flash.display.MovieClip;
	import flash.geom.Vector3D;



	public class Frame2 extends MovieClip
	{
		private var emitter: Emitter3D;
		private var renderer: DisplayObjectRenderer;
		private var nay: int;

		var resolume: Resolume = new Resolume();

public var paramScaleX: FloatParameter;

		public function Frame2()
		{
			resolume.addParameterListener(parameterChanged);


			//create as many different parameters as you like
			paramScaleX = resolume.addFloatParameter("Scale X", 0.5);

			emitter = new Emitter3D();
			emitter.counter = new Blast(nay);

			emitter.addInitializer(new ImageClass(Bird));
			emitter.addInitializer(new Position(new BoxZone(nay, 380, 580, new Vector3D(0, 0, 0), new Vector3D(0, 1, 0), new Vector3D(0, 0, 1))));
			emitter.addInitializer(new Velocity(new SphereZone(new Vector3D(0, 0, 0), 150, 100)));

			emitter.addAction(new ApproachNeighbours(nay, 100));
			emitter.addAction(new MatchVelocity(40, 200));
			emitter.addAction(new MinimumDistance(20, 600));
			emitter.addAction(new RotateToDirection());
			emitter.addAction(new BoundingBox(-300, 300, -200, 200, -300, 300));
			emitter.addAction(new SpeedLimit(100, true));
			emitter.addAction(new SpeedLimit(nay));
			emitter.addAction(new Move());

			renderer = new DisplayObjectRenderer(false);
			renderer.x = 350;
			renderer.y = 250;
			renderer.addEmitter(emitter);
			addChild(renderer);

			renderer.camera.position = new Vector3D(0, 0, -400);
			renderer.camera.target = new Vector3D(0, 0, 0);
			renderer.camera.projectionDistance = 400;
			var controller: FirstPersonCamera = new FirstPersonCamera(stage, renderer.camera);
			controller.start();

			emitter.start();
			// constructor code
		}
		public function parameterChanged(event: ChangeEvent): void
		{
			//check to see what parameter was changed
			if (event.object == this.paramScaleX)
			{
				//now it gets interesting
				//do whatever you like with the value of the parameter
				nay = this.paramScaleX.getValue() * 100.0;
			}
		}

	}
}

/*
 * FLINT PARTICLE SYSTEM
 * .....................
 *
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org/
 *
 * Licence Agreement
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */