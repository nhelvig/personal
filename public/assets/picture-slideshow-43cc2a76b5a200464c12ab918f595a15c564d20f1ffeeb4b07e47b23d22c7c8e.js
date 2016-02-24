var photos=new Array()
var photoslink=new Array()
var which=0

//define images. You can have as many as you want:
photos[0]="tall-window.jpg"
photos[1]="treehouses.jpg"
photos[2]="rooster.jpg"


//do NOT edit pass this line

var preloadedimages=new Array()
for (i=0;i<photos.length;i++){
    preloadedimages[i]=new Image()
    preloadedimages[i].src=photos[i]
}


function applyeffect(){
    if (document.all && photoslider.filters){
        photoslider.filters.revealTrans.Transition=Math.floor(Math.random()*23)
        photoslider.filters.revealTrans.stop()
        photoslider.filters.revealTrans.apply()
    }
}



function playeffect(){
    if (document.all && photoslider.filters)
        photoslider.filters.revealTrans.play()
}

function keeptrack(){
    window.status="Image "+(which+1)+" of "+photos.length
}


function backward(){
    if (which>0){
        which--
        applyeffect()
        document.images.photoslider.src=photos[which]
        playeffect()
        keeptrack()
    }
}

function forward(){
    if (which<photos.length-1){
        which++
        applyeffect()
        document.images.photoslider.src=photos[which]
        playeffect()
        keeptrack()
    }
}

function transport(){
    window.location=photoslink[which]
}
