/*
Capture.as
	Saves the frames of your Flash file and exports them as PNGs to a script
	you host on your webserver. I wrote this up real quick. Plenty of room for improvement

How to use:

 var cap:Capture = new Capture(mySprite);
 ...

 // on every frame you must tell it to record
 cap.record();
 ...

 // When done recording
 cap.save();

*/

package {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	
	public class Capture	
	{
		private var screen = false;
		private var record_data:Array = new Array();
		private var script_url = 'http://mywebsite.com/save_img.php';
		
		public function Capture(screen):void
		{	
			this.screen = screen;
		}
		
		public function record():void
		{
			var bmpd:BitmapData = new BitmapData(this.screen.width, this.screen.height);
			bmpd.draw(screen);
			record_data.push(PNGEnc.encode(bmpd));
		}
	
		public function save():void
		{
			trace('Saving!');
			
			for (var i:int = 0; i < record_data.length; i++) {
				var request:URLRequest = new URLRequest(this.script_url + '?name=' + (i + 1) + '.png');
				var loader: URLLoader = new URLLoader();
				request.contentType = 'application/octet-stream';
				request.method = URLRequestMethod.POST;
				request.data = record_data[i];
				loader.load(request);
			}
		}
	}
}