<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/context/global-context.jspf" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Wirk</title>
    <link rel="stylesheet" href="${CSS}/fontawesome-5.5/css/all.min.css" />
    <link rel="stylesheet" href="${CSS}/slick/slick.css">
    <link rel="stylesheet" href="${CSS}/slick/slick-theme.css">
    <link rel="stylesheet" href="${CSS}/magnific-popup/magnific-popup.css">
    <link rel="stylesheet" href="${CSS}/bootstrap.min.css" />
    <link rel="stylesheet" href="${CSS}/main.css" />

  </head>
  <body>    
    <section id="infinite" class="text-white tm-font-big tm-parallax">
      <nav class="navbar navbar-expand-md tm-navbar" id="tmNav">              
        <div class="container">   
          <div class="tm-next">
              <a href="#infinite" class="navbar-brand">Wirk</a>
          </div>             
            
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fas fa-bars navbar-toggler-icon"></i>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                  <a class="nav-link tm-nav-link" href="#infinite">Home</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link tm-nav-link" href="#convert">Convert</a>
              </li>                
            </ul>
          </div>        
        </div>
      </nav>
      
      <div class="text-center tm-hero-text-container">
        <div class="tm-hero-text-container-inner">
            <h2 class="tm-hero-title">W i r k</h2>
            <p class="tm-hero-subtitle">
              2D 이미지를 사용해서
              <br>3D 이미지로 바꿔보세요!
            </p>
        </div>        
      </div>

      <div class="tm-next tm-intro-next">
        <a href="#convert" class="text-center tm-down-arrow-link">
          <i class="fas fa-2x fa-arrow-down tm-down-arrow"></i>
        </a>
      </div>      
    </section>

    <section id="convert" class="tm-section-pad-top">
      
      <div class="container">            
            <div class="row tm-content-box">
        		<div class="col-lg-1">
                    <i class="far fa-3x fa-chart-bar text-center tm-icon"></i>
                </div>
                <div class="col-lg-5">
                    <div class="tm-intro-text-container">
                        <h2 class="tm-text-primary mb-4">이미지 업로드</h2>
                        	<form action="/upload" method="post" enctype="multipart/form-data">
                        	<input type="file" name="file" accept="image/*" onchange="setThumbnail(event);" id="upIMG"/>
                        		<button type="submit" id="btn_upload">Upload</button>	
                        	</form>
	                        <div class=".tm-input-image-view">
	                          <div id="image_container"></div>
                    </div>
                </div>
                <!--
                <div class="col-lg-1">
                    <i class="far fa-3x fa-comment-alt text-center tm-icon"></i>
                </div>
                <div class="col-lg-5">
                    <div class="tm-intro-text-container">
                        <h2 class="tm-text-primary mb-4">결과 확인</h2>
                          
                    </div>
                </div>
                -->
            </div>
        </div>
    </section>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
      function setThumbnail(event) {
        var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          img.style.height = "400px";
          document.querySelector("div#image_container").appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
      }

      function getOffSet(){
        var _offset = 450;
        var windowHeight = window.innerHeight;

        if(windowHeight > 500) {
          _offset = 400;
        } 
        if(windowHeight > 680) {
          _offset = 300
        }
        if(windowHeight > 830) {
          _offset = 210;
        }

        return _offset;
      }

      function setParallaxPosition($doc, multiplier, $object){
        var offset = getOffSet();
        var from_top = $doc.scrollTop(),
          bg_css = 'center ' +(multiplier * from_top - offset) + 'px';
        $object.css({"background-position" : bg_css });
      }
      
      var background_image_parallax = function($object, multiplier, forceSet){
        multiplier = typeof multiplier !== 'undefined' ? multiplier : 0.5;
        multiplier = 1 - multiplier;
        var $doc = $(document);

        if(forceSet) {
          setParallaxPosition($doc, multiplier, $object);
        } else {
          $(window).scroll(function(){          
            setParallaxPosition($doc, multiplier, $object);
          });
        }
      };

      var ba=ckground_image_parallax_2 = function($object, multiplier){
        multiplier = typeof multiplier !== 'undefined' ? multiplier : 0.5;
        multiplier = 1 - multiplier;
        var $doc = $(document);
        $object.css({"background-attachment" : "fixed"});
        
        $(window).scroll(function(){
          if($(window).width() > 768) {
            var firstTop = $object.offset().top,
                pos = $(window).scrollTop(),
                yPos = Math.round((multiplier * (firstTop - pos)) - 186);              

            var bg_css = 'center ' + yPos + 'px';

            $object.css({"background-position" : bg_css });
          } else {
            $object.css({"background-position" : "center" });
          }
        });
      };
      
      $(function(){
        // Hero Section - Background Parallax
        background_image_parallax($(".tm-parallax"), 0.30, false);
        background_image_parallax_2($("#contact"), 0.80);   
        background_image_parallax_2($("#testimonials"), 0.80);   
        
        // Handle window resize
        window.addEventListener('resize', function(){
          background_image_parallax($(".tm-parallax"), 0.30, true);
        }, true);

        // Detect window scroll and update navbar
        $(window).scroll(function(e){          
          if($(document).scrollTop() > 120) {
            $('.tm-navbar').addClass("scroll");
          } else {
            $('.tm-navbar').removeClass("scroll");
          }
        });
        
        // Close mobile menu after click 
        $('#tmNav a').on('click', function(){
          $('.navbar-collapse').removeClass('show'); 
        })

        // Scroll to corresponding section with animation
        $('#tmNav').singlePageNav({
          'easing': 'easeInOutExpo',
          'speed': 600
        });        
        
        $("a").on('click', function(event) {
          if (this.hash !== "") {
            event.preventDefault();
            var hash = this.hash;

            $('html, body').animate({
              scrollTop: $(hash).offset().top
            }, 600, 'easeInOutExpo', function(){
              window.location.hash = hash;
            });
          } // End if
        });

        // Pop up
        $('.tm-gallery').magnificPopup({
          delegate: 'a',
          type: 'image',
          gallery: { enabled: true }
        });

        $('.tm-testimonials-carousel').slick({
          dots: true,
          prevArrow: false,
          nextArrow: false,
          infinite: false,
          slidesToShow: 3,
          slidesToScroll: 1,
          responsive: [
            {
              breakpoint: 992,
              settings: {
                slidesToShow: 2
              }
            },
            {
              breakpoint: 768,
              settings: {
                slidesToShow: 2
              }
            }, 
            {
              breakpoint: 480,
              settings: {
                  slidesToShow: 1
              }                 
            }
          ]
        });

        $('.tm-gallery').slick({
          dots: true,
          infinite: false,
          slidesToShow: 5,
          slidesToScroll: 2,
          responsive: [
          {
            breakpoint: 1199,
            settings: {
              slidesToShow: 4,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 991,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 767,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 1
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
        ]
        });
      });
    </script>
  </body>
</html>