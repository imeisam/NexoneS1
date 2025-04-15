function FadeIn(Object, Timeout) {
    $(Object).fadeIn(Timeout).css('display', 'block');
}

function FadeOut(Object, Timeout) {
    $(Object).fadeOut(Timeout)
    setTimeout(function(){
        $(Object).css("display", "none");
    }, Timeout)
}

const Targeting = Vue.createApp({
    data() {
        return {
            Show: false,
            ChangeTextIconColor: false, // This is if you want to change the color of the icon next to the option text with the text color
            StandardEyeIcon: 'https://cdn.discordapp.com/attachments/949410021823877160/1237117969742430368/1234.png?ex=663a7b64&is=663929e4&hm=5be58e8bf39d98906487611a123b31645a6bcf03d1ecfc4a163bee37ee39cbdf&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML 
            CurrentIcon: 'https://cdn.discordapp.com/attachments/949410021823877160/1237117969742430368/1234.png?ex=663a7b64&is=663929e4&hm=5be58e8bf39d98906487611a123b31645a6bcf03d1ecfc4a163bee37ee39cbdf&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML
            SuccessIcon: 'https://cdn.discordapp.com/attachments/949410021823877160/1237117969742430368/1234.png?ex=663a7b64&is=663929e4&hm=5be58e8bf39d98906487611a123b31645a6bcf03d1ecfc4a163bee37ee39cbdf&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML
            SuccessColor: "#10CC9F;",
            StandardColor: "white",
            TargetHTML: "",
            TargetEyeStyleObject: {
                color: "white", // This is the standardcolor, change this to the same as the StandardColor if you have changed it
            },
        }
    },
    destroyed() {
        window.removeEventListener("message", this.messageListener);
        window.removeEventListener("mousedown", this.mouseListener);
        window.removeEventListener("keydown", this.keyListener);
    },
    mounted() {
        this.messageListener = window.addEventListener("message", (event) => {
            switch (event.data.response) {
                case 'opencircle':
                    let xx = event.data.post
                    OpenCircle(xx.x, xx.y, xx.id)
                    break;
                case 'closecircle':
                    FadeOut("#circle-"+event.data.post.id, 200)
                    break;
                case 'updatecircle':
                    $("#circle-"+event.data.post.id).css('left', event.data.post.x*100+"%");
                    $("#circle-"+event.data.post.id).css('right', (100 - event.data.post.x*100)+"%");
                    $("#circle-"+event.data.post.id).css('top', event.data.post.y*100+"%");
                    $("#circle-"+event.data.post.id).css('bottom',(100 - event.data.post.y*100)+"%");
                    break;
                case "openTarget":
                    this.OpenTarget();
                    break;
                case "closeTarget":
                    this.CloseTarget();
                    break;
                case "foundTarget":
                    $('.hexagon').css('filter', 'drop-shadow(0vw 0vw .8vw #DC143C70)');
                    $('.hexagon img').css('filter', 'drop-shadow(0vw 0vw .8vw #DC143C70)');
                    $('.hexagon img').css('opacity', '0.9');
                    $('#target-eye').css('filter', 'drop-shadow(0vw 0vw .8vw #DC143C70)');
                    $('.alttakim img').css('top', '51.8vh');
                    $('.alttakim img').css('opacity', '0.6');
                    this.FoundTarget(event.data);
                    break;
                case "validTarget":
                    this.ValidTarget(event.data);
                    break;
                case "leftTarget":
                    $('.hexagon').css('filter', 'drop-shadow(0vw 0vw 0.0vw #DC143C70)');
                    $('.hexagon img').css('opacity', '0.9');
                    $('.hexagon img').css('filter', 'drop-shadow(0vw 0vw 0.0vw #DC143C70)');
                    $('#target-eye').css('filter', 'drop-shadow(0vw 0vw 0.0vw #DC143C70)');
                    $('.alttakim img').css('top', '50.8vh');
                    $('.alttakim img').css('opacity', '0.0');
                    this.LeftTarget();
                    break;
            }
        });

        this.mouseListener = window.addEventListener("mousedown", (event) => {
            let element = event.target;
            let split = element.id.split("-");
            if (split[0] === 'target' && split[1] !== 'eye') {
                $.post(`https://qb-target/selectTarget`, JSON.stringify(Number(split[1]) + 1));
                this.TargetHTML = "";
                this.Show = false;
            }

            if (event.button == 2) {
                this.CloseTarget();
                $.post(`https://qb-target/closeTarget`);
            }
        });

        this.keyListener = window.addEventListener("keydown", (event) => {
            if (event.key == 'Escape' || event.key == 'Backspace') {
                this.CloseTarget();
                $.post(`https://qb-target/closeTarget`);
            }
        });
    },
    methods: {
        OpenTarget() {
            this.TargetHTML = "";
            this.Show = true;
            this.TargetEyeStyleObject.color = this.StandardColor;
        },

        CloseTarget() {
            this.TargetHTML = "";
            this.TargetEyeStyleObject.color = this.StandardColor;
            this.Show = false;
            this.CurrentIcon = this.StandardEyeIcon;
        },

        FoundTarget(item) {
            if (item.data) {
                this.CurrentIcon = item.data;
            } else {
                this.CurrentIcon = this.SuccessIcon;
            }
            this.TargetEyeStyleObject.color = this.SuccessColor;
        },

        ValidTarget(item) {
            this.TargetHTML = "";
            let TargetLabel = this.TargetHTML;
            const FoundColor = this.SuccessColor;
            const ResetColor = this.StandardColor;
            const AlsoChangeTextIconColor = this.ChangeTextIconColor;
            item.data.forEach(function(item, index) {
                if (AlsoChangeTextIconColor) {
                    TargetLabel += "<div class='target-item' id='target-" + index + "' style='margin-bottom: 0.8vh;'><span id='target-icon-" + index + "' style='color: " + ResetColor + "'><i style='margin-left: .35vw; color: #e2e2e2;' class='" + item.icon + "'></i></span>&nbsp" + item.label + "</div>";
                } else {
                    TargetLabel += "<div class='target-item' id='target-" + index + "' style='margin-bottom: 0.8vh;'><span id='target-icon-" + index + "' style='color: " + FoundColor + "'><i style='margin-left: .35vw; color: #e2e2e2;' class='" + item.icon + "'></i></span>&nbsp" + item.label + "</div>";
                };
                
                setTimeout(function() {
                    const hoverelem = document.getElementById("target-" + index);

                    hoverelem.addEventListener("mouseenter", function(event) {
                        event.target.style.background = 'linear-gradient(180deg, #f30e3e40 0%, #f30e3e50 11.98%, #f30e3e60 44.27%, #f30e3e65 100%)';
                    });
                    
                    hoverelem.addEventListener("mouseleave", function(event) {
                        event.target.style.background = 'linear-gradient(180deg, rgba(29, 14, 19, 0.4) 0%, rgba(29, 14, 19, 0.6) 11.98%, rgba(29, 14, 19, 0.7) 44.27%, rgba(29, 14, 19, 0.8) 100%)';
                    });
                }, 10)
            });
            this.TargetHTML = TargetLabel;
        },

        LeftTarget() {
            this.TargetHTML = "";
            this.CurrentIcon = this.StandardEyeIcon;
            this.TargetEyeStyleObject.color = this.StandardColor;
        }
    }
});

Targeting.use(Quasar, {
    config: {
        loadingBar: { skipHijack: true }
    }
});
Targeting.mount("#target-wrapper");

function OpenCircle(x, y, id) {
    $(".circle").append(`
        <img id="circle-${id}" style="display: none; top: 25vw; left: 50vw; position: absolute; width: 30px; height: 30px;" src="css/circle.svg" alt="">
    `);
    $("#circle-"+id).css('left', x*100+"%");
    $("#circle-"+id).css('right', (100 - x*100)+"%");
    $("#circle-"+id).css('top', y*100+"%");
    $("#circle-"+id).css('bottom',(100 - y*100)+"%");
    FadeIn("#circle-"+id, 200)
}