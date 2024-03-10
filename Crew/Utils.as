package
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   
   public class Utils
   {
       
      
      public function Utils()
      {
         super();
      }
      
      public static function loaderSwf(path:String, callback:*) : *
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callback);
         loader.load(new URLRequest(path));
      }
      
      public static function checkPath(a:String, b:Array) : Boolean
      {
         if(a != b[b.length - 1])
         {
            return true;
         }
         return false;
      }
      
      public static function genSwfFilePath(folderName:String, fileName:String) : String
      {
         var path:* = null;
         return folderName + "/" + fileName + ".swf";
      }
      
      public static function checkDuplicate(a:*, b:Array) : Boolean
      {
         for(var i:* = 0; i < b.length; i++)
         {
            if(a.name == b[i].name)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function checkClass(a:String, b:Array) : Boolean
      {
         for(var i:* = 0; i < b.length; i++)
         {
            if(a == b[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public static function searchClass(swfName:*, objData:*, classType:*) : *
      {
         return objData[swfName][classType];
      }
      
      public static function orderName(a:*, b:*) : int
      {
         var name1:* = a["name"];
         var name2:* = b["name"];
         name1 = Number(name1.replace("skill_",""));
         name2 = Number(name2.replace("skill_",""));
         if(name1 < name2)
         {
            return -1;
         }
         if(name1 > name2)
         {
            return 1;
         }
         return 0;
      }
      
      public static function addMouseEventClick(obj:*, callback:*) : *
      {
         obj.addEventListener(MouseEvent.CLICK,callback);
      }
      
      public static function removeMouseEventClick(obj:*, callback:*) : *
      {
         obj.removeEventListener(MouseEvent.CLICK,callback);
      }
      
      public static function hasMouseEventClick(obj:*) : Boolean
      {
         return obj.hasEventListener(MouseEvent.CLICK);
      }
      
      public static function removeChildIfExistAt(obj:*, index:int) : *
      {
         if(obj.numChildren > index)
         {
            obj.removeChildAt(index);
         }
      }
      
      public static function strContains(str:String, val:String) : Boolean
      {
         return str.indexOf(val) >= 0;
      }
   }
}
