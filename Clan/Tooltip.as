package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="Tooltip")]
   public dynamic class Tooltip extends MovieClip
   {
       
      
      public var back:MovieClip;
      
      public var chakra_txt:TextField;
      
      public var cooldown_txt:TextField;
      
      public var damage_txt:TextField;
      
      public var desc_txt:TextField;
      
      public var level_txt:TextField;
      
      public var name_txt:TextField;
      
      public var type_txt:TextField;
      
      public function Tooltip()
      {
         super();
      }
   }
}
