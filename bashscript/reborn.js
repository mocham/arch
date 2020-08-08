//var ability = true;
var ability = false;
clicku = (reborned)=>{
    if (ability){
        var abils = document.getElementsByClassName("hero-abil-icon");
        if (abils != undefined){
            if (abils.length > 0){
                abils[0].getElementsByClassName("icon")[0].click();
            }
        }
        var skills = document.getElementsByClassName("skills-pic");
        for (var j = 0; j < skills.length; j++){
            if (skills[j].className != "skills-pic disabled"){
                skills[j].getElementsByClassName("icon")[0].click();
                //ability = false;
                break;
            }
        }
    }

    var greens = document.getElementsByClassName("color-btn green");
    if (greens != undefined){
        for (var j = greens.length-1; j >= 0; j--){
            if (greens[j].className != "color-btn green disabled"){
                greens[j].click();
                break;
            }
        }
    }
    if (reborned){
        var gbtn = document.getElementsByClassName("btn-simple-green btn-ok");
        if (gbtn.length == 1){
            gbtn[0].click();
        }
    }
    reborned = false;
    var reb = document.getElementsByClassName("quest open");
    if (reb.length == 3){
        reb[1].click();
        var ok = document.getElementsByClassName("btn-simple-gold btn-ok-free");
        if (ok.length == 1){
            ok[0].click();
            reborned = true;
            //ability = true;
        }
    }
    setTimeout(()=>{clicku(reborned);}, 300);
};
clicku();
