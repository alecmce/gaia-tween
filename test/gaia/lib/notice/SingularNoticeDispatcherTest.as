package gaia.lib.notice
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	
	public class SingularNoticeDispatcherTest
	{
		private var dispatcher:SingularNoticeDispatcher;
		private var param:Object;
		private var count:int;
		
		[Before]
		public function before():void
		{
			dispatcher = new SingularNoticeDispatcher();
			param = {};
			count = 0;
		}
		
		[After]
		public function after():void
		{
			dispatcher = null;
		}
		
		[Test]
		public function add_listener_works():void
		{
			assertTrue(dispatcher.addOnce(trivialListener));
		}
		
		[Test]
		public function add_listener_fails_on_duplicate():void
		{
			dispatcher.addOnce(trivialListener);
			assertFalse(dispatcher.addOnce(trivialListener));
		}
		
		[Test]
		public function remove_unadded_listener_fails():void
		{
			assertFalse(dispatcher.remove(trivialListener));
		}
		
		[Test]
		public function remove_added_listener_succeeds():void
		{
			dispatcher.addOnce(trivialListener);
			assertTrue(dispatcher.remove(trivialListener));
		}
		
		[Test]
		public function added_listener_receives_dispatch():void
		{
			dispatcher.addOnce(passListener);
			dispatcher.dispatch(param);
		}
		
		[Test]
		public function added_and_removed_listener_doesnt_receive_dispatch():void
		{
			dispatcher.addOnce(failListener);
			dispatcher.remove(failListener);
			dispatcher.dispatch(param);
		}
		
		[Test]
		public function added_listener_receives_one_dispatch():void
		{
			dispatcher.addOnce(multipleListener);
			dispatcher.dispatch(param);
			dispatcher.dispatch(param);
			dispatcher.dispatch(param);
			assertEquals(1, count);
		}

		[Test]
		public function after_dispatch_listener_can_be_added():void
		{
			dispatcher.addOnce(trivialListener);
			dispatcher.dispatch(param);
			assertTrue(dispatcher.addOnce(trivialListener));
		}
		
		[Test]
		public function a_listener_added_in_dispatch_gets_next_dispatch():void
		{
			dispatcher.addOnce(stepListener);
			dispatcher.dispatch(param);
			dispatcher.dispatch(param);
			assertEquals(2, count);
		}
		
		private function stepListener(obj:Object):void
		{
			dispatcher.addOnce(stepListener);
			++count;
		}
		
		private function trivialListener(obj:Object):void
		{
			
		}
		
		private function passListener(obj:Object):void
		{
			assertSame(param, obj);
		}
		
		private function failListener(obj:Object):void
		{
			fail("this listener should not be called");
		}
		
		private function multipleListener(obj:Object):void
		{
			++count;
		}
		
	}
}
