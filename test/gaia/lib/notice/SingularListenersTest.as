package gaia.lib.notice
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;

	
	public class SingularListenersTest
	{
		private var listeners:SingularListeners;
		private var param:Object;
		private var count:uint;
		
		[Before]
		public function before():void
		{
			listeners = new SingularListeners();
			param = {};
			count = 0;
		}
		
		[After]
		public function after():void
		{
			listeners = null;
		}
		
		[Test]
		public function add_listener_works():void
		{
			assertTrue(listeners.add(trivialListener));
		}
		
		[Test]
		public function add_listener_fails_on_duplicate():void
		{
			listeners.add(trivialListener);
			assertFalse(listeners.add(trivialListener));
		}
		
		[Test]
		public function remove_unadded_listener_fails():void
		{
			assertFalse(listeners.remove(trivialListener));
		}
		
		[Test]
		public function remove_added_listener_succeeds():void
		{
			listeners.add(trivialListener);
			assertTrue(listeners.remove(trivialListener));
		}
		
		[Test]
		public function added_listener_receives_dispatch():void
		{
			listeners.add(passListener);
			listeners.dispatch([param]);
		}
		
		[Test]
		public function added_and_removed_listener_doesnt_receive_dispatch():void
		{
			listeners.add(failListener);
			listeners.remove(failListener);
			listeners.dispatch([param]);
		}
		
		[Test]
		public function added_listener_receives_one_dispatch():void
		{
			listeners.add(multipleListener);
			listeners.dispatch([param]);
			listeners.dispatch([param]);
			listeners.dispatch([param]);
			assertEquals(1, count);
		}

		[Test]
		public function after_dispatch_listener_can_be_added():void
		{
			listeners.add(trivialListener);
			listeners.dispatch([param]);
			assertTrue(listeners.add(trivialListener));
		}
		
		[Test]
		public function a_listener_added_in_dispatch_gets_next_dispatch():void
		{
			listeners.add(stepListener);
			listeners.dispatch([param]);
			listeners.dispatch([param]);
			assertEquals(2, count);
		}
		private function stepListener(obj:Object):void
		{
			listeners.add(stepListener);
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
