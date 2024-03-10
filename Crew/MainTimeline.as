package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MainTimeline extends MovieClip
   {
       
      
      public var btnNextPage:SimpleButton;
      
      public var btnPrevPage:SimpleButton;
      
      public var cd:MovieClip;
      
      public var chakra_txt:TextField;
      
      public var clan2Btn:MovieClip;
      
      public var clanBtn:MovieClip;
      
      public var cooldown_txt:TextField;
      
      public var cp:MovieClip;
      
      public var damage_txt:TextField;
      
      public var desc_txt:TextField;
      
      public var dmg:MovieClip;
      
      public var exitBtn:SimpleButton;
      
      public var gearIconMc:MovieClip;
      
      public var gs_desc_txt:TextField;
      
      public var gs_name_txt:TextField;
      
      public var level_txt:TextField;
      
      public var name_txt:TextField;
      
      public var preview:MovieClip;
      
      public var previewBtn:SimpleButton;
      
      public var season_txt:TextField;
      
      public var skillIconMc:MovieClip;
      
      public var skillTypeIcon:MovieClip;
      
      public var skill_0:MovieClip;
      
      public var skill_1:MovieClip;
      
      public var skill_2:MovieClip;
      
      public var skill_3:MovieClip;
      
      public var skill_4:MovieClip;
      
      public var skill_5:MovieClip;
      
      public var skill_6:MovieClip;
      
      public var skill_7:MovieClip;
      
      public var swf_txt:TextField;
      
      public var unreleaseBtn:MovieClip;
      
      private var libraryPath:* = "language/data_library_en.swf";
      
      private var itemLibraryPath:*;
      
      private var wpnData:Array;
      
      private var hairData:Array;
      
      private var acsyData:Array;
      
      private var backData:Array;
      
      private var setData:Array;
      
      private var skillData:Array;
      
      private var petData:Array;
      
      private var enemyData:Array;
      
      private var unreleaseData:*;
      
      private var rewardData:*;
      
      private var otherData:*;
      
      private var unreleaseTitleData:*;
      
      private var bossSeasonData:*;
      
      private var getSkillDetails:*;
      
      private var getWpnDetails:*;
      
      private var getBackDetails:*;
      
      private var getSetBoyDetails:*;
      
      private var getSetGirlDetails:*;
      
      private var getHairDetails:*;
      
      private var getAcsyDetails:*;
      
      private var getGearSetDetails:*;
      
      private var getEnemyDetails:*;
      
      private var getItemDetails:*;
      
      private var getPetDetails:*;
      
      private var isLoading:*;
      
      private var loadingCount:*;
      
      private var currentPage:* = 1;
      
      private var totalPage:* = 1;
      
      private var currentListPage:* = 1;
      
      private var totalListPage:* = 1;
      
      private var currentTotalSwfPerPage:* = 0;
      
      private var currentData:*;
      
      private var gearsetText:*;
      
      private const MAX_ITEM_PER_PAGE:* = 8;
      
      private const MAX_PET_SKILL:* = 6;
      
      private var allData:*;
      
      private var allPath:*;
      
      private var itemData:*;
      
      private var id:*;
      
      public function MainTimeline()
      {
         this.gearsetText = {};
         this.allData = {};
         this.allPath = [];
         this.itemData = {};
         super();
         this.initUI();
         this.initialData();
         this.clearList();
         this.clearInfo();
         this.isLoading = true;
         this.currentData = this.rewardData;
         this.currentPage = 1;
         this.totalPage = this.currentData.length;
      }
      
      public function initUI() : void
      {
         stop();
         this["exitBtn"].visible = false;
         Utils.addMouseEventClick(this["exitBtn"],this.onExit);
         this["previewBtn"].visible = false;
         this["preview"].visible = false;
         Utils.addMouseEventClick(this["previewBtn"],this.onPreview);
         this["unreleaseBtn"].txt.text = "Unrelease";
         this["unreleaseBtn"].stop();
         this["unreleaseBtn"].buttonMode = true;
         Utils.addMouseEventClick(this["unreleaseBtn"],this.show);
         this["clanBtn"].txt.text = "S1-S54";
         this["clanBtn"].stop();
         this["clanBtn"].buttonMode = true;
         Utils.addMouseEventClick(this["clanBtn"],this.show);
         this["clan2Btn"].txt.text = "Other";
         this["clan2Btn"].stop();
         this["clan2Btn"].buttonMode = true;
         this["clan2Btn"].visible = true;
         Utils.addMouseEventClick(this["clan2Btn"],this.show);
         this["skillTypeIcon"].gotoAndStop("idle");
         this["dmg"].gotoAndStop(1);
         this["cp"].gotoAndStop(1);
         Utils.loaderSwf(this.libraryPath,this.loadData);
      }
      
      public function initialData() : void
      {
         this.wpnData = Data.crew_wpn;
         this.acsyData = Data.crew_acsy;
         this.backData = Data.crew_back;
         this.skillData = Data.crew_skill;
         this.unreleaseData = Data.crew_unrelease;
         this.rewardData = Data.crew_reward;
         this.otherData = Data.crew_other;
         this.unreleaseTitleData = Data.crew_unrelease_title;
         this.itemLibraryPath = Data.crew_item_path;
      }
      
      public function loadData(e:Event) : void
      {
         var data:Class = null;
         var systemData:* = undefined;
         trace("Loading Data Library");
         try
         {
            data = Class(e.target.applicationDomain.getDefinition("ninjasaga.language.SystemDataEN"));
            systemData = data;
            this.getSkillDetails = systemData.SKILL;
            this.getWpnDetails = systemData.WEAPON;
            this.getBackDetails = systemData.BACK_ITEM;
            this.getSetBoyDetails = systemData.BODY_SET_BOY;
            this.getSetGirlDetails = systemData.BODY_SET_GIRL;
            this.getHairDetails = systemData.HAIR;
            this.getAcsyDetails = systemData.ACCESSORY;
            this.getGearSetDetails = systemData.GEAR_SET;
            this.getEnemyDetails = systemData.ENEMY;
            this.getItemDetails = systemData.ITEM;
            this.getPetDetails = systemData.PET;
            trace("Loading Data Library Finish");
         }
         catch(e:*)
         {
            trace(e);
            trace("Loading Data Library Error");
         }
         this.initGearsetText();
         this.loadingItemIconSwf();
      }
      
      public function getDetails(swfName:String) : *
      {
         if(swfName.indexOf("wpn_") >= 0)
         {
            return this.getWpnDetails;
         }
         if(swfName.indexOf("back_") >= 0)
         {
            return this.getBackDetails;
         }
         if(swfName.indexOf("set_") >= 0)
         {
            if(swfName.substr(-1,1) == "0")
            {
               return this.getSetBoyDetails;
            }
            return this.getSetGirlDetails;
         }
         if(swfName.indexOf("skill_") >= 0)
         {
            return this.getSkillDetails;
         }
         if(swfName.indexOf("acsy_") >= 0)
         {
            return this.getAcsyDetails;
         }
         if(swfName.indexOf("pet_") >= 0)
         {
            return this.getPetDetails;
         }
         if(swfName.indexOf("hair_") >= 0)
         {
            return this.getHairDetails;
         }
         if(swfName.indexOf("item_") >= 0)
         {
            return this.getItemDetails;
         }
         if(swfName.indexOf("ene_") >= 0)
         {
            return this.getEnemyDetails;
         }
      }
      
      internal function loadingItemIconSwf() : void
      {
         var i:* = undefined;
         this.loadingCount = 0;
         for(i in this.itemLibraryPath)
         {
            Utils.loaderSwf(this.itemLibraryPath[i],this.onLoadFinishItem);
         }
      }
      
      public function loadingSwfPerPage(counter:int) : void
      {
         var i:* = undefined;
         var folderName:* = undefined;
         this.getCurrentTotalSwfPerPage(counter);
         var swfPath:* = "";
         for(i in this.currentData[counter])
         {
            folderName = "";
            if(this.currentData[counter][i].indexOf("pet") >= 0)
            {
               folderName = "pets";
            }
            else if(this.currentData[counter][i].indexOf("enemy") >= 0)
            {
               folderName = "enemies";
            }
            else if(this.currentData[counter][i].indexOf("skill") < 0)
            {
               folderName = "items";
            }
            else
            {
               folderName = "skills";
            }
            swfPath = Utils.genSwfFilePath(folderName,this.currentData[counter][i]);
            this.loadIcon(swfPath);
         }
      }
      
      public function getCurrentTotalSwfPerPage(counter:int) : void
      {
         this.currentTotalSwfPerPage = this.currentData[counter].length;
      }
      
      public function loadingPerPage() : void
      {
         this.isLoading = true;
         this.loadingCount = 0;
         if(this.currentData == this.otherData)
         {
            this.currentTotalSwfPerPage = 1;
            this.loadEnemySwf(this.currentPage - 1);
         }
         else
         {
            this.loadingSwfPerPage(this.currentPage - 1);
         }
      }
      
      public function loadIcon(path:String) : void
      {
         Utils.loaderSwf(path,this.onLoadFinish);
      }
      
      public function onLoadFinish(e:Event) : void
      {
         var objName:* = undefined;
         var obj:* = undefined;
         var animName:* = undefined;
         try
         {
            objName = e.target.url;
            objName = objName.slice(objName.lastIndexOf("/") + 1);
            objName = objName.slice(0,-4);
            obj = new Object();
            obj["name"] = objName;
            animName = objName.replace("s","S");
            if(e.target.applicationDomain.hasDefinition("icon"))
            {
               obj["icon"] = Class(e.target.applicationDomain.getDefinition("icon"));
            }
            if(e.target.applicationDomain.hasDefinition(animName))
            {
               obj["animation"] = Class(e.target.applicationDomain.getDefinition(animName));
            }
            if(e.target.applicationDomain.hasDefinition("accessory"))
            {
               obj["accessory"] = Class(e.target.applicationDomain.getDefinition("accessory"));
            }
            if(e.target.applicationDomain.hasDefinition("back_item"))
            {
               obj["back_item"] = Class(e.target.applicationDomain.getDefinition("back_item"));
            }
            if(e.target.applicationDomain.hasDefinition("weapon"))
            {
               obj["weapon"] = Class(e.target.applicationDomain.getDefinition("weapon"));
            }
            if(e.target.applicationDomain.hasDefinition("StaticFullBody"))
            {
               obj["StaticFullBody"] = Class(e.target.applicationDomain.getDefinition("StaticFullBody"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_0"))
            {
               obj["Skill_0"] = Class(e.target.applicationDomain.getDefinition("Skill_0"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_1"))
            {
               obj["Skill_1"] = Class(e.target.applicationDomain.getDefinition("Skill_1"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_2"))
            {
               obj["Skill_2"] = Class(e.target.applicationDomain.getDefinition("Skill_2"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_3"))
            {
               obj["Skill_3"] = Class(e.target.applicationDomain.getDefinition("Skill_3"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_4"))
            {
               obj["Skill_4"] = Class(e.target.applicationDomain.getDefinition("Skill_4"));
            }
            if(e.target.applicationDomain.hasDefinition("Skill_5"))
            {
               obj["Skill_5"] = Class(e.target.applicationDomain.getDefinition("Skill_5"));
            }
            this.allData[obj["name"]] = obj;
         }
         catch(err:Error)
         {
            trace(e.target.url);
            trace("Not Found");
         }
         ++this.loadingCount;
         this.allData["length"] = this.loadingCount;
         if(this.allData["length"] == this.currentTotalSwfPerPage)
         {
            this.isLoading = false;
            this.updateList();
         }
      }
      
      internal function onLoadFinishItem(e:Event) : void
      {
         var index:*;
         var itemName:* = undefined;
         var obj:* = undefined;
         var num:* = undefined;
         var fileName:* = e.target.url;
         fileName = fileName.slice(fileName.lastIndexOf("/") + 1);
         fileName = fileName.slice(0,-4);
         fileName = fileName.replace("item_icon_","");
         var front:* = Number(fileName.substr(0,fileName.lastIndexOf("-")));
         var back:* = Number(fileName.slice(fileName.lastIndexOf("-") + 1));
         for(index = front; index <= back; index++)
         {
            try
            {
               num = index;
               itemName = "item_" + num;
               if(e.target.applicationDomain.hasDefinition(itemName))
               {
                  obj = new Object();
                  obj["name"] = itemName;
                  obj["icon"] = Class(e.target.applicationDomain.getDefinition(itemName));
                  this.itemData[obj["name"]] = obj;
               }
            }
            catch(err:Error)
            {
            }
         }
         ++this.loadingCount;
         if(this.loadingCount == this.itemLibraryPath.length)
         {
            this.loadingPerPage();
         }
      }
      
      public function show(e:MouseEvent) : void
      {
         if(e.target.parent == this["clanBtn"])
         {
            this.currentData = this.rewardData;
            this.resetList();
         }
         else if(e.target.parent == this["unreleaseBtn"])
         {
            this.currentData = this.unreleaseData;
            this.resetList();
         }
         else if(e.target.parent == this["clan2Btn"])
         {
            this.currentData = this.otherData;
            this.resetList();
         }
      }
      
      public function pageNavigator() : void
      {
         var isFirstPage:* = this.currentPage == 1;
         var isLastPage:* = this.currentPage == this.totalPage;
         this.btnNextPage.visible = !isLastPage;
         this.btnPrevPage.visible = !isFirstPage;
      }
      
      public function changePage(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.btnNextPage:
               ++this.currentPage;
               if(this.currentPage > this.totalPage)
               {
                  this.currentPage = this.totalPage;
                  return;
               }
               break;
            case this.btnPrevPage:
               --this.currentPage;
               if(this.currentPage <= 0)
               {
                  this.currentPage = 1;
                  return;
               }
               break;
         }
         this.currentListPage = 1;
         this.allData = {};
         this.clearInfo();
         this.updateList();
      }
      
      public function resetList() : void
      {
         this.currentPage = 1;
         this.totalPage = this.currentData.length;
         this.currentListPage = 1;
         this.allData = {};
         this.clearInfo();
         this.updateList();
      }
      
      public function clearList() : void
      {
         for(var i:* = 0; i < this.MAX_ITEM_PER_PAGE; i++)
         {
            this["skill_" + i].visible = false;
         }
      }
      
      public function loadEnemySwf(counter:*) : *
      {
         var enemySwf:* = this.otherData[counter][0];
         trace(enemySwf);
         var swfPath:* = Utils.genSwfFilePath("enemies",enemySwf);
         this.loadIcon(swfPath);
      }
      
      public function updateList() : void
      {
         var reward:* = undefined;
         var start:* = undefined;
         var end:* = undefined;
         var j:* = undefined;
         var i:* = undefined;
         var swfName:* = undefined;
         var itemicon:* = undefined;
         var itemId:* = undefined;
         var itemName:* = undefined;
         var itemLevel:* = undefined;
         this.clearList();
         this.pageNavigator();
         if(this["btnNextPage"].hasEventListener(MouseEvent.CLICK))
         {
            Utils.removeMouseEventClick(this["btnNextPage"],this.changePage);
         }
         if(this["btnPrevPage"].hasEventListener(MouseEvent.CLICK))
         {
            Utils.removeMouseEventClick(this["btnPrevPage"],this.changePage);
         }
         if(this.allData["length"] == undefined)
         {
            this.loadingPerPage();
         }
         if(!this.isLoading)
         {
            this.loadingCount = 0;
            reward = this.currentData[this.currentPage - 1];
            start = 0;
            end = reward.length;
            this["season_txt"].text = this.getSeasonText();
            this.infoGearSet();
            j = 0;
            for(i = start; i < end; i++)
            {
               try
               {
                  swfName = reward[i];
                  itemicon = this.createItemIcon(swfName);
                  Utils.removeChildIfExistAt(this["skill_" + j]["gearIconMC"],2);
                  Utils.removeChildIfExistAt(this["skill_" + j]["skillIconMC"],2);
                  if(Utils.hasMouseEventClick(this["skill_" + j]))
                  {
                     Utils.removeMouseEventClick(this["skill_" + j],this.showInfo);
                  }
                  itemId = this.getItemId(swfName);
                  itemName = this.getItemName(itemId,swfName);
                  itemLevel = this.getItemLevel(itemId,swfName);
                  this.configureItemIcon(j,itemicon,swfName);
                  this.addEventListenersToSkill(j,swfName);
                  this.updateInfoDisplay(j,itemName,itemLevel);
               }
               catch(e:*)
               {
                  trace(e);
                  trace(swfName);
               }
               finally
               {
                  j++;
               }
            }
            Utils.addMouseEventClick(this["btnNextPage"],this.changePage);
            Utils.addMouseEventClick(this["btnPrevPage"],this.changePage);
         }
      }
      
      public function getSeasonText() : String
      {
         if(this.currentData == this.unreleaseData)
         {
            return this.unreleaseTitleData[this.currentPage - 1];
         }
         if(this.currentData == this.otherData)
         {
            return "Other";
         }
         var seasonNum:* = this.currentPage;
         return "Crew S" + seasonNum;
      }
      
      public function getItemId(swfName:String) : Number
      {
         if(swfName.indexOf("wpn_") >= 0)
         {
            return Number(swfName.replace("wpn_",""));
         }
         if(swfName.indexOf("back_") >= 0)
         {
            return Number(swfName.replace("back_",""));
         }
         if(swfName.indexOf("set_") >= 0)
         {
            return Number(this.searchID(swfName));
         }
         if(swfName.indexOf("skill_") >= 0)
         {
            return Number(swfName.replace("skill_",""));
         }
         if(swfName.indexOf("acsy_") >= 0)
         {
            return Number(swfName.replace("acsy_",""));
         }
         if(swfName.indexOf("pet_") >= 0)
         {
            return Number(swfName.replace("pet_",""));
         }
         if(swfName.indexOf("hair_") >= 0)
         {
            return Number(this.searchID(swfName.replace("hair_","")));
         }
         if(swfName.indexOf("item_") >= 0)
         {
            return Number(swfName.replace("item_",""));
         }
         if(swfName.indexOf("ene_") >= 0)
         {
            return Number(swfName.replace("ene_",""));
         }
         return 0;
      }
      
      public function getItemName(itemid:*, swfName:*) : String
      {
         var itemName:*;
         var infoType:* = swfName.split("_")[0];
         if(infoType == "ene")
         {
            infoType = "enemy";
         }
         itemName = "";
         try
         {
            itemName = String(this.getDetails(swfName)[infoType + itemid]["name"]);
         }
         catch(e:*)
         {
            itemName = "Not Found";
         }
         finally
         {
            return itemName;
         }
      }
      
      public function getItemLevel(itemid:*, swfName:*) : String
      {
         var itemLevel:*;
         var skillsPet:* = undefined;
         var infoType:* = swfName.split("_")[0];
         if(infoType == "ene")
         {
            infoType = "enemy";
         }
         itemLevel = "";
         try
         {
            if(infoType == "pet")
            {
               skillsPet = this.getDetails(swfName)[infoType + itemid]["skill"];
               itemLevel = String(this.getDetails(swfName)[infoType + itemid]["skill"][skillsPet.length - 1]["level"]);
            }
            itemLevel = String(this.getDetails(swfName)[infoType + itemid]["level"]);
         }
         catch(e:*)
         {
            itemLevel = "0";
         }
         finally
         {
            return itemLevel;
         }
      }
      
      public function createItemIcon(swfName:String) : *
      {
         var itemCls:* = undefined;
         if(this.currentData == this.otherData)
         {
            if(swfName.indexOf("item_") >= 0)
            {
               itemCls = Utils.searchClass(swfName,this.itemData,"icon");
            }
            else
            {
               itemCls = Utils.searchClass(swfName,this.allData,"icon");
            }
         }
         else
         {
            itemCls = Utils.searchClass(swfName,this.allData,"icon");
         }
         var itemIcon:* = new itemCls();
         if(swfName.indexOf("skill_") >= 0)
         {
            itemIcon.scaleX = 1.75;
            itemIcon.scaleY = 1.75;
            itemIcon.x = -45;
            itemIcon.y = -45;
         }
         else
         {
            itemIcon.scaleX = 0.75;
            itemIcon.scaleY = 0.75;
            itemIcon.y = 35;
         }
         itemIcon.name = swfName;
         return itemIcon;
      }
      
      public function configureItemIcon(index:int, itemIcon:*, swfName:String) : void
      {
         var skillIconMC:* = this["skill_" + index]["skillIconMC"];
         var gearIconMC:* = this["skill_" + index]["gearIconMC"];
         if(swfName.indexOf("skill_") >= 0)
         {
            gearIconMC.visible = false;
            skillIconMC.visible = true;
            skillIconMC.addChild(itemIcon);
         }
         else
         {
            gearIconMC.visible = true;
            skillIconMC.visible = false;
            gearIconMC.addChild(itemIcon);
         }
      }
      
      public function addEventListenersToSkill(index:int, item:String) : void
      {
         var skill:* = this["skill_" + index];
         Utils.addMouseEventClick(skill,this.showInfo);
         skill.visible = true;
      }
      
      public function updateInfoDisplay(index:int, itemName:String, itemLevel:String) : void
      {
         var skill:* = this["skill_" + index];
         skill["nameTxt"].text = itemName;
         skill["levelMC"]["levelTxt"].text = itemLevel;
      }
      
      public function getInfoIcon(swfName:*) : void
      {
         var isSkill:* = swfName.indexOf("skill") >= 0;
         this["gearIconMc"].visible = !isSkill;
         this["skillIconMc"].visible = isSkill;
         var iconMc:* = !!isSkill ? this["skillIconMc"] : this["gearIconMc"];
         Utils.removeChildIfExistAt(iconMc,2);
         var icon:* = this.createItemIcon(swfName);
         iconMc.addChild(icon);
      }
      
      public function infoUIVisiblity(infoType:*) : void
      {
         var isSkill:* = infoType == "skill";
         var isWpn:* = infoType == "wpn";
         var isPet:* = infoType == "pet";
         this.dmg.visible = isSkill || isWpn;
         this.cp.visible = isSkill;
         this.cd.visible = isSkill;
         this.skillTypeIcon.gotoAndStop("idle");
         this.damage_txt.visible = isSkill || isWpn;
         this.chakra_txt.visible = isSkill;
         this.cooldown_txt.visible = isSkill;
         this.previewBtn.visible = isSkill || isPet;
      }
      
      public function clearInfo() : void
      {
         Utils.removeChildIfExistAt(this["skillIconMc"],2);
         Utils.removeChildIfExistAt(this["gearIconMc"],2);
         this["skillTypeIcon"].gotoAndStop("idle");
         this.name_txt.text = "Name";
         this.level_txt.text = "0";
         this.damage_txt.text = "0";
         this.chakra_txt.text = "0";
         this.cooldown_txt.text = "0";
         this.desc_txt.htmlText = "Effect/Description";
         this.swf_txt.text = "swfName";
         this["previewBtn"].visible = false;
      }
      
      public function showInfo(param1:MouseEvent) : void
      {
         var targetid:*;
         var infoType:*;
         var details:*;
         var swfName:* = undefined;
         var skillsPet:* = undefined;
         this.clearInfo();
         targetid = param1.target.parent.name;
         targetid = targetid.replace("skill_","");
         if(this["skill_" + targetid]["gearIconMC"].visible == false)
         {
            swfName = this["skill_" + targetid]["skillIconMC"].getChildAt(2).name;
         }
         else
         {
            swfName = this["skill_" + targetid]["gearIconMC"].getChildAt(2).name;
         }
         infoType = swfName.split("_")[0];
         if(infoType == "ene")
         {
            infoType = "enemy";
         }
         this.infoUIVisiblity(infoType);
         details = this.getDetails(swfName);
         this.id = this.getItemId(swfName);
         try
         {
            this.name_txt.text = String(details[infoType + this.id]["name"]);
            if(infoType == "pet")
            {
               skillsPet = this.getDetails(swfName)[infoType + this.id]["skill"];
               this.level_txt.text = String(this.getDetails(swfName)[infoType + this.id]["skill"][skillsPet.length - 1]["level"]);
            }
            else
            {
               this.level_txt.text = String(details[infoType + this.id]["level"]);
            }
            this.desc_txt.htmlText = String(details[infoType + this.id]["description"]);
            this.swf_txt.text = String(details[infoType + this.id]["swfName"]);
            if(infoType == "skill" || infoType == "wpn")
            {
               this.damage_txt.text = String(details[infoType + this.id]["damage"]);
            }
            if(infoType == "skill")
            {
               this.skillTypeIcon.gotoAndStop(String(details[infoType + this.id]["type"]));
               this.chakra_txt.text = String(details[infoType + this.id]["cp"]);
               this.cooldown_txt.text = String(details[infoType + this.id]["cooldown"]);
            }
            this.getInfoIcon(swfName);
         }
         catch(error:Error)
         {
            this.name_txt.text = "Not Found";
            this.level_txt.text = "0";
            this.desc_txt.htmlText = "Not Found. Try again!";
            this.swf_txt.text = "";
            this.skillTypeIcon.gotoAndStop("idle");
            this.damage_txt.text = "0";
            this.chakra_txt.text = "0";
            this.cooldown_txt.text = "0";
            getInfoIcon(swfName);
         }
      }
      
      public function onPreview(e:MouseEvent) : void
      {
         var icon:* = undefined;
         var cls:* = undefined;
         Utils.removeChildIfExistAt(this["preview"],8);
         this["preview"].visible = true;
         this.exitBtn.visible = true;
         var skillName:* = "";
         var isSkill:* = this["skillIconMc"].visible == true;
         if(isSkill)
         {
            skillName = this["skillIconMc"].getChildAt(2).name;
            cls = Utils.searchClass(skillName,this.allData,"animation");
         }
         else
         {
            skillName = this["gearIconMc"].getChildAt(2).name;
            cls = Utils.searchClass(skillName,this.allData,"StaticFullBody");
         }
         icon = new cls();
         icon.scaleX = 0.5;
         icon.scaleY = 0.5;
         icon.x = 450;
         icon.y = 350;
         this["preview"].addChild(icon);
         if(isSkill)
         {
            icon.gotoAndPlay(2);
         }
      }
      
      public function onExit(e:MouseEvent) : void
      {
         if(this["preview"].numChildren > 8)
         {
            this["preview"].getChildAt(8).stop();
            this["preview"].removeChildAt(8);
         }
         this["preview"].visible = false;
         this["exitBtn"].visible = false;
      }
      
      public function searchID(param:*) : int
      {
         var hairId:* = undefined;
         var setId:* = undefined;
         if(param.substr(0,3) != "set")
         {
            hairId = [665,666,685,686,719,720,771,772,810,811];
            return hairId[this.hairData.indexOf("hair_" + param)];
         }
         setId = [2184,2185,2250,2251,2316,2317,2438,2439,2586,2587];
         return setId[this.setData.indexOf(param)];
      }
      
      public function initGearsetText() : void
      {
         this.gearsetText["defender_poison"] = "Poisons the target by [amount]% for [duration] turns";
         this.gearsetText["pet_weaken_fix_num"] = "Weaken enemy upon each weapon attack - reduce [amount] HP damage for [duration] turns";
         this.gearsetText["add_hp_amount_present"] = "Recover HP by [amount]% every turn";
         this.gearsetText["add_hp_amount"] = "Recovers [amount] HP every turn";
         this.gearsetText["add_damage_bonus"] = "Increase all attack damage by [amount]%";
         this.gearsetText["add_dodge_reduction"] = "Increase [amount]% accuracy";
         this.gearsetText["attacker_damage_bonus"] = "Increases attack damage by [amount]% until the end of next turn after using the weapon";
         this.gearsetText["add_critical_chance"] = "Increase critical chance by [amount]%";
         this.gearsetText["reduce_damage_amount"] = "Decrease damage taken by [amount]%";
         this.gearsetText["add_cp_amount_present"] = "Recover CP by [amount]% every turn";
         this.gearsetText["absorb_attacker_hp_present"] = "Has [chance]% chance to absorb [amount]% HP of enemy who attack you";
         this.gearsetText["xp_bouns"] = "Increase mission XP reward by [amount]";
         this.gearsetText["add_purify_chance"] = "Increase purify chance every turn by [amount]%";
         this.gearsetText["effect_agility"] = "Increases agility by [amount]";
         this.gearsetText["effect_max_cp_present"] = "Increase max. CP by [amount]%";
         this.gearsetText["recieve_damage_cp"] = "Recover CP after HP reduction. (Amount: [amount]% of HP reduction)";
         this.gearsetText["reduce_damage_bonus"] = "Reduce damage taken by [amount]";
         this.gearsetText["add_cp_amount"] = "Recover [amount] CP at the start of every turn";
         this.gearsetText["add_dodge_random"] = "Increases dodge chance by [amount]%";
         this.gearsetText["effect_max_hp_present"] = "Increase max. HP by [amount]%";
         this.gearsetText["dmgbonus_fix_num"] = "Additional[amount]HP damage upon all attack.";
         this.gearsetText["attacker_critical_damage_bonus"] = "Increase critical damage[amount]%";
         this.gearsetText["add_sp_amount_present"] = "Recover [amount]% SP at the start of every turn.";
         this.gearsetText["reduce_hp_present"] = "[chance]% chance to reduce enemy\'s [amount]% HP upon each attack.";
      }
      
      public function searchGearSetEffect(a:*) : *
      {
         var gearSetDesc:* = undefined;
         var j:* = undefined;
         var temp:* = undefined;
         for(var i:* = 1; i <= 87; i++)
         {
            if(this.getGearSetDetails["gearset" + i] != null)
            {
               if(this.getGearSetDetails["gearset" + i]["name"] == a)
               {
                  gearSetDesc = "";
                  for(j = 0; j < this.getGearSetDetails["gearset" + i]["effect"].length; j++)
                  {
                     temp = this.gearsetText[this.getGearSetDetails["gearset" + i]["effect"][j]["type"]];
                     temp = temp.replace("[amount]",this.getGearSetDetails["gearset" + i]["effect"][j]["amount"]);
                     temp = temp.replace("[duration]",this.getGearSetDetails["gearset" + i]["effect"][j]["duration"]);
                     temp = temp.replace("[chance]",this.getGearSetDetails["gearset" + i]["effect"][j]["chance"]);
                     temp += "\n";
                     gearSetDesc += temp;
                  }
                  return gearSetDesc;
               }
            }
         }
         return null;
      }
      
      public function infoGearSet() : *
      {
         var gsName:* = "Crew S" + this.currentPage;
         if(this.currentPage == 49 || this.currentPage == 50)
         {
            gsName = "S" + this.currentPage + " Crew";
         }
         else
         {
            gsName += " Set";
         }
         try
         {
            this.gs_name_txt.text = gsName;
            this.gs_desc_txt.htmlText = this.searchGearSetEffect(gsName);
         }
         catch(error:Error)
         {
            this.gs_name_txt.text = "";
            this.gs_desc_txt.htmlText = "";
         }
      }
   }
}
