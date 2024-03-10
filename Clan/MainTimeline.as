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
      
      public var clanBlacksmithBtn:MovieClip;
      
      public var clanBtn:MovieClip;
      
      public var clanShopBtn:MovieClip;
      
      public var cooldown_txt:TextField;
      
      public var cp:MovieClip;
      
      public var damage_txt:TextField;
      
      public var desc_txt:TextField;
      
      public var dmg:MovieClip;
      
      public var exitBtn:SimpleButton;
      
      public var gearIconMc:MovieClip;
      
      public var level_txt:TextField;
      
      public var name_txt:TextField;
      
      public var nextPage:SimpleButton;
      
      public var page_txt:TextField;
      
      public var prevPage:SimpleButton;
      
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
      
      private var rewardData:*;
      
      private var reward2Data:*;
      
      private var unreleaseData:*;
      
      private var shopData:*;
      
      private var blacksmithData:*;
      
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
      
      private const MAX_ITEM_PER_PAGE:* = 7;
      
      private const MAX_PET_SKILL:* = 6;
      
      private var allData:*;
      
      private var allPath:*;
      
      private var itemData:*;
      
      private var id:*;
      
      public function MainTimeline()
      {
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
         this["clanBtn"].txt.text = "S1-S55";
         this["clanBtn"].stop();
         this["clanBtn"].buttonMode = true;
         Utils.addMouseEventClick(this["clanBtn"],this.show);
         this["clan2Btn"].txt.text = "S56-S125";
         this["clan2Btn"].stop();
         this["clan2Btn"].buttonMode = true;
         this["clan2Btn"].visible = true;
         Utils.addMouseEventClick(this["clan2Btn"],this.show);
         this["clanShopBtn"].txt.text = "Clan Shop";
         this["clanShopBtn"].stop();
         this["clanShopBtn"].buttonMode = true;
         Utils.addMouseEventClick(this["clanShopBtn"],this.show);
         this["clanBlacksmithBtn"].txt.text = "Blacksmith";
         this["clanBlacksmithBtn"].stop();
         this["clanBlacksmithBtn"].buttonMode = true;
         Utils.addMouseEventClick(this["clanBlacksmithBtn"],this.show);
         this["skillTypeIcon"].gotoAndStop("idle");
         this["dmg"].gotoAndStop(1);
         this["cp"].gotoAndStop(1);
         this["page_txt"].text = this.currentListPage + "/" + this.totalListPage;
         Utils.loaderSwf(this.libraryPath,this.loadData);
      }
      
      public function initialData() : void
      {
         this.wpnData = Data.clan_wpn;
         this.backData = Data.clan_back;
         this.setData = Data.clan_set_b.concat(Data.clan_set_b_2,Data.clan_set_g,Data.clan_set_g_2);
         this.skillData = Data.clan_skill;
         this.rewardData = Data.clan_reward;
         this.reward2Data = Data.clan_reward_2;
         this.unreleaseData = Data.clan_unrelease;
         this.blacksmithData = Data.clan_blacksmith;
         this.shopData = Data.clan_shop;
         this.itemLibraryPath = Data.clan_item_path;
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
         this.loadingPerPage();
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
         this.loadingSwfPerPage(this.currentPage - 1);
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
         else if(e.target.parent == this["clan2Btn"])
         {
            this.currentData = this.reward2Data;
            this.resetList();
         }
         else if(e.target.parent == this["unreleaseBtn"])
         {
            this.currentData = this.unreleaseData;
            this.resetList();
         }
         else if(e.target.parent == this["clanBlacksmithBtn"])
         {
            this.currentData = this.blacksmithData;
            this.resetList();
         }
         else if(e.target.parent == this["clanShopBtn"])
         {
            this.currentData = this.shopData;
            this.resetList();
         }
      }
      
      public function pageNavigator() : void
      {
         var isFirstPage:* = this.currentPage == 1;
         var isLastPage:* = this.currentPage == this.totalPage;
         this["btnNextPage"].visible = !isLastPage;
         this["btnPrevPage"].visible = !isFirstPage;
         var isFirstListPage:* = this.currentListPage == 1;
         var isLastListPage:* = this.currentListPage == this.totalListPage;
         this["nextPage"].visible = !isLastListPage;
         this["prevPage"].visible = !isFirstListPage;
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
      
      public function changeListPage(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.nextPage:
               ++this.currentListPage;
               if(this.currentListPage > this.totalListPage)
               {
                  this.currentListPage = this.totalListPage;
                  return;
               }
               break;
            case this.prevPage:
               --this.currentListPage;
               if(this.currentListPage <= 0)
               {
                  this.currentListPage = 1;
                  return;
               }
               break;
         }
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
         if(this["nextPage"].hasEventListener(MouseEvent.CLICK))
         {
            Utils.removeMouseEventClick(this["nextPage"],this.changeListPage);
         }
         if(this["prevPage"].hasEventListener(MouseEvent.CLICK))
         {
            Utils.removeMouseEventClick(this["prevPage"],this.changeListPage);
         }
         if(this.allData["length"] == undefined)
         {
            this.loadingPerPage();
         }
         if(!this.isLoading)
         {
            this.loadingCount = 0;
            reward = this.currentData[this.currentPage - 1];
            this.totalListPage = Math.ceil(reward.length / this.MAX_ITEM_PER_PAGE);
            start = (this.currentListPage - 1) * this.MAX_ITEM_PER_PAGE;
            end = reward.length < this.currentListPage * this.MAX_ITEM_PER_PAGE ? reward.length : this.currentListPage * this.MAX_ITEM_PER_PAGE;
            this["season_txt"].text = this.getSeasonText();
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
            this["page_txt"].text = this.currentListPage + "/" + this.totalListPage;
            Utils.addMouseEventClick(this["btnNextPage"],this.changePage);
            Utils.addMouseEventClick(this["btnPrevPage"],this.changePage);
            Utils.addMouseEventClick(this["nextPage"],this.changeListPage);
            Utils.addMouseEventClick(this["prevPage"],this.changeListPage);
            this.pageNavigator();
         }
      }
      
      public function getSeasonText() : String
      {
         if(this.currentData == this.unreleaseData)
         {
            return ["Unselected","Season 126","Unknown"][this.currentPage - 1];
         }
         if(this.currentData == this.shopData)
         {
            return ["Weapon","Back Item"][this.currentPage - 1];
         }
         if(this.currentData == this.blacksmithData)
         {
            return "Blacksmith";
         }
         var seasonNum:* = this.currentPage;
         if(this.currentData == this.reward2Data)
         {
            seasonNum = this.currentPage + 55;
         }
         return "Season " + seasonNum;
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
         var itemCls:* = Utils.searchClass(swfName,this.allData,"icon");
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
         for(var i:* = 144; i <= 2817; i++)
         {
            if(this.getSetBoyDetails["set" + i] != null)
            {
               if(this.getSetBoyDetails["set" + i]["swfName"] == param)
               {
                  return i;
               }
            }
            if(this.getSetGirlDetails["set" + i] != null)
            {
               if(this.getSetGirlDetails["set" + i]["swfName"] == param)
               {
                  return i;
               }
            }
         }
         return -1;
      }
   }
}
