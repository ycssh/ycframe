$(function(){
    var $tabCotent=$('.tabContent'),
    aLi=$tabCotent.find('li'),
    $J_pre=$('#J_pre'),
    $J_next=$('#J_next'),
    $leftOpacityBox=$J_pre.parent();
    $rightOpacityBox= $J_next.parent();
    liWidth=parseInt(aLi.css('width')),
    aLiLength=aLi.length,
    
    listLi=[];
    var interval;
    for(var j=aLiLength,len=aLiLength-3;j>=len;j--){
            aLi.eq(j).clone().prependTo($tabCotent);
        }
        for(var j=0,len=2;j<=len;j++){
            aLi.eq(j).clone().appendTo($tabCotent);
        }
       $tabCotent.css('left','-1832px') ;
    ulWidth=(aLiLength+6)*liWidth,
     $tabCotent.width(ulWidth);
    $tabCotent.mouseover(function(){
        clearTimeout(interval);
        interval=null;
    }).mouseout(function(){
        clearTimeout(interval);
        interval=null;
        autoPlay();
    });
    $J_next.click(function(){
        clearTimeout(interval);
        interval=null;
        goImg(false);
    });
    $J_pre.click(function(){
        clearTimeout(interval);
        interval=null;
        goImg(true);
    })
    function goImg(flag){
        var nowLeft=parseInt($tabCotent.position().left);
        if(!flag){
            if(nowLeft>166-(aLiLength+3)*liWidth){
                $tabCotent.stop(true,true).animate({'left':nowLeft-liWidth+'px'},300);
            }else{
                $tabCotent.stop(true,true).animate({'left':nowLeft-liWidth+'px'},300,function(){
                    $tabCotent.css('left',-3*liWidth-500+'px');
                });
            }
        }else{
            if(nowLeft<(-500-liWidth)){
                $tabCotent.stop(true,true).animate({'left':nowLeft+liWidth+'px'},300);
            }else{
                $tabCotent.stop(true,true).animate({'left':nowLeft+liWidth+'px'},300,function(){
                    $tabCotent.css('left',-(aLiLength+1)*liWidth+166+'px');
                });
            }
        }
    }   
    function autoPlay(){
       interval=setInterval(goImg,'6000');
    }
    autoPlay();
})