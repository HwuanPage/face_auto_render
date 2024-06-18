var identifiers = [
    'd6952c02c3774d3a9fa31ea8d21dc020', 'e4655ce1313f4b0b8bcaa7bbdbe65f48', 'dcff3270eb2e404787df3baedceedb99', '9fc59e515ca94c68bab519ae6cd3193e', '6d34b114024149369f89775327013455', '55b2cda0cb4046a586879b306bfd6ad9', 'c236c3a8aad949fca9c1779d2e81a816', '128fec646d984d388009b9cc048a83f1', '92ddfb83d7fa468f8610ad1bf18cca58', '361cddfa5bcf4568abd72ae73a783dc5', '4e7914df0f9d4f82bdd14ab576aec7a2', '7dfb1504fe9c434da3f91c14d1c5aa85', '83900375d45449a981f241c949735ad3', 'ab9b9b623dfe4a4984a268f66b0a00f7', '4e47184496f7487fa4e98904163b497c', '4faff2931fc14237b7c33f09ee8c8cd1', '875e16ecbbaf4d668b66e360f6572254', 'a2fd3b2f6967466d9ebcbcb3560f1147', '37ec0c8b804a446eb2e823e2cc89fd26', 'a224c28ced4342dab70ba1f5876ad9fe', 'f9aaeb6db75b42c997a860bafb096483', 'bcecaeea53cc4994b41c5c3a57396071', '9e26b3d5005e49a6a859086227e9985e', '674d173a59024888aa9368629d059384', '0c9b8dd00d754c6586da47be2b9b6d4d', 'ae2e5811ac5d4e27b82816ba66eb154e',
    '432dc8e9611843d9878d8966548d5d26', 'ecb57be9043b45e3ab3108b850254485',
    'b25f45f53b184373b93ac5858d0bf1af', '165a79be2de141dcb4fc37cfdb7b5dbb'
    ];
    
    var client, index, inLoadingState, loadingPlane, direction, context, startWaitCheck;
    
    var OnViewerInitializeCallback = function(){
      inLoadingState = true;
      console.log( 'Initializing Viewer');
    }
    
    var OnViewerReadyCallback = function(){
      setTimeout(function(){
        loadingPlane.fadeOut(500,function(){
          inLoadingState = false;
        });
      },200);
    } 
    
    var OnSuccessfullyLoadedCallback = function( api ){
      context = api;
      api.setPostProcessing( {
          vignetteEnable: false
      } );
      api.setCycleMode( 'one' );
      api.start();
      api.addEventListener( 'viewerready', OnViewerReadyCallback );
    }
    
    var OnViewerErrorCallback = function(){
      console.log( 'Viewer error' );
    }
    
    // shim layer with setTimeout fallback
    window.requestAnimFrame = (function(){
      return  window.requestAnimationFrame       ||
              window.webkitRequestAnimationFrame ||
              window.mozRequestAnimationFrame    ||
              function( callback ){
                window.setTimeout(callback, 1000 / 60);
              };
    })();
    
    
    // usage:
    // instead of setInterval(render, 16) ....
    (function animloop(){
      requestAnimFrame(animloop);
      update();
    })();
    
    var waitTime = 60000, oldTime = null;
    function update(){
      console.log($('iframe').contents().find(".main-progress-percentage").val());
      //console.log(inUse, inLoadingState, oldTime);
      if(!inLoadingState && oldTime != null){
          var currTime = new Date().getTime();
          if(currTime > oldTime + waitTime ){
            oldTime = currTime;
            index++;
            loadCurrentScene();
          }
      }else{
        oldTime = (new Date()).getTime();
      }
    }
    window.addEventListener("message", receiveMessage, false);
    
    function receiveMessage(event)
    {
      var origin = event.origin || event.originalEvent.origin; // For Chrome, the origin property is in 
      console.log(event);
    }
    function awake(){
      identifiers = shuffle(identifiers);
      direction = 1;
      loadingPlane = $('.loading-plane');
      inLoadingState = false;
      index = 0;
      client = new Sketchfab( '1.0.0', $('#api-frame')[0] ); 
      
      
    $("#bl1").click(function(){return false;});
    $("#bl2").click(function(){return false;});
      
      
      $('.arrow.left').click(function(){
        index--;
        loadCurrentScene();
      });
      
      $('.arrow.right').click(function(){
        index++;
        loadCurrentScene();
      });
      
      loadCurrentScene();
    }
    
    function normalizeIdentifierIndex(){
      index = index % identifiers.length;
      if(index < 0){
        index = identifiers.length -1;
      }
    }
    
    function loadCurrentScene(){
      normalizeIdentifierIndex();
      var identifier = identifiers[index];
      OnViewerInitializeCallback();
    
      $(loadingPlane).fadeIn(500, function(){
          if(!!context){
            context.stop();
          }
          client.init( identifier, {
            // 0 = skip intial animation, DEFAULT 1 = zoom in on the model
            camera: 1,
            // 1 = cycle thourgh the render options
            //blending: 0,
            // 0..n = time of cycle animation, DEFAULT 0
            autospin: direction*0.05,
            // 0..n = stay n seconds until jumping to nex annotation
            annotation_cycle: 4,
            // [PRO ONLY] 1 = transparent background, DEFAULT 0 = opaque
            transparent: 1,
            // 1 = stop user from stopping player, DEFAULT 0 = player is stoppable
            ui_stop: 1,
            // 1 = preload textures before displaying, DEFAULT 0 = stream textures
            preload: 1,
            ui_controls: 0,
            ui_infos: 0,
            success: OnSuccessfullyLoadedCallback,
            error: OnViewerErrorCallback
          } );
      });
      direction = direction === 1 ? -1 : 1;
    }
    
    function shuffle(array) {
      var currentIndex = array.length, temporaryValue, randomIndex;
    
      // While there remain elements to shuffle...
      while (0 !== currentIndex) {
    
        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;
    
        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
      }
    
      return array;
    }
    
    awake();