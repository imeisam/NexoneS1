const s_click = new Audio('./sounds/click.mp3');
const s_over = new Audio('./sounds/over.wav');
const s_transition = new Audio('./sounds/transition.ogg');
const s_unlock = new Audio('./sounds/unlock.mp3');
const s_pop = new Audio('./sounds/pop.mp3');
const alarm = new Audio('./sounds/alarm.mp3');

s_click.volume = 0.1;
s_over.volume = 0.1;
s_transition.volume = 0.2;
s_unlock.volume = 1;
s_pop.volume = 0.3;
alarm.volume = 0.0;

function fetch(event, data) {
    return $.post('https://origen_housing/' + event, JSON.stringify(data)).promise();
}

function exportEvent(script, event, data) {
    return $.post('https://' + script + '/' + event, JSON.stringify(data)).promise();
}

function TriggerCallback(event, data) {
    data.trigger = event;
    return $.post('https://origen_housing/TriggerCallback', JSON.stringify(data)).promise();
}

let app = new Vue({
    el: '#app',
    data() {
        return {
            visible: true,
            translations: [],
            swiper: null,
            modals: [],
            currentModal: null,
    
            gizmoMode: false,
            selectedShell: null,
            selectedExterior: null,
    
            allowedExtensions: [],
    
            controlsHelp: {
                visible: false,
                title: false,
                keysData: [],
            },
    
            info: {
                visible: false,
                text: '',
            },
    
            menu: {
                preview: {
                    visible: false,
                    title: '',
                    items: [],
                    path: '',
                    hidden: false,
                    itemLength: 0,
                },
                management: false,
                houses: {
                    visible: false,
                    list: {},
                }
            },
    
            furniture: {
                visible: false,
                minimized: false,
                defaultPrice: null,
                selectedOption: 'all',
                mode: 'normal',
                action: 'move',
                selectCategory: null,
                currentObject: false,
                selectedEntity: false,
                isMoving: false,
                categories: [],
                items: [],

                buyedItems: {},
                selectedObject: null,
            },
    
            loading: false,
    
            search: {
                house: {
                    value: '',
                },
                management: {
                    value: '',
                },
            },
    
            notifications: [],
    
            iteminfo: {
                title: '',
                price: 0,
                extra: ``, // html
            },
    
            exteriors: [],
    
            shells : {
                small: [],
    
                medium: [],
    
                big: [],
            },
    
            ipls: [],
    
            stages: [],
    
            houseList: [],
    
            house: {
                visible: false,
                swiper: null,
                data : [],
                currentTab: 'cameras',
                upgrades: {},
                doors: {},
    
                doorLimit: null,
                currentUpgrade: null,
            },    
            
            creationData: {
                name: '',
                doors: [],
                data: {
                    price: 0,
                    number: 0,
                    type: 'shell',
                    interior_category: false,
                    allowVehicles: false,
                    showBlip: false,
                    model: '',
                },
                positions: {},
                settings: {},
                construction: {
                    enabled: false,
                    model: '',
                    time: 0,
                    stage: 0,
                    coords: [],
                },
                exterior: [],
                useGarage: false,
            },
    
            buyMenu: false,
    
            upgrades: {
                visible: false,
                interval: null,
                title: '',
                item: '',
                info: {
                    visible: false,
                    title: '',
                    text: '',
                    position: 0,
                }
            },
    
            colors: {
                red: [255, 0, 0],
                green: [0, 255, 0],
                blue: [0, 0, 255],
                yellow: [255, 255, 0],
                orange: [255, 165, 0],
                purple: [128, 0, 128],
                pink: [255, 192, 203],
                white: [255, 255, 255],
                black: [0, 0, 0],
                brown: [165, 42, 42],
                cyan: [0, 255, 255],
                gray: [128, 128, 128],
                lime: [0, 255, 0],
                magenta: [255, 0, 255],
                olive: [128, 128, 0],
                silver: [192, 192, 192],
                teal: [0, 128, 128],
                gold: [255, 215, 0],
            },
            currentLight: null,
    
            isEditingName: false,
            editedName: '',
    
            isEditingURL: null,
            newUrl: '',
    
            elevator: {
                visible: false,
                currentFloor: null,
                floors: [],
            },
    
            currentPage: 1,
            itemsPerPage: 10,
        }
    },

    computed: {
        totalPages() {
            return Math.ceil(this.filteredHouses.length / this.itemsPerPage);
        },
        filteredHouses() {
            const search = this.search.management.value;
            if (!search) return Object.values(this.houseList);
            return Object.values(this.houseList).filter(
                item => item && 
                item.name.toLowerCase().includes(search.toLowerCase()) ||
                item.citizenid && item.citizenid.toLowerCase().includes(search.toLowerCase()) ||
                item.data && item.data.type && item.data.type.toLowerCase().includes(search.toLowerCase()) ||
                item.data && item.data.location && item.data.location.toLowerCase().includes(search.toLowerCase())
            );
        },
        paginatedHouses() {
            if (this.currentPage == 0 && this.filteredHouses.length > 0) this.currentPage = 1;
            if (this.filteredHouses.length === 0) this.currentPage = 0;
            const start = (this.currentPage - 1) * this.itemsPerPage;
            const end = start + this.itemsPerPage;
            return this.filteredHouses.slice(start, end);
        },
    },

    methods: {
        setDefaultImage: function(event) {
            event.target.src = './img/default.png';
        },
        getImageUrl: function(name) {
            if (!this.house.data || !this.ipls[this.house.data.data.model]) return;

            if (this.ipls[this.house.data.data.model]) {
                return './img/ipls/' + this.ipls[this.house.data.data.model].prefix + '_' + name + '.png';
            }

            return './img/ipls/' + this.house.data.data.model + '_' + name + '.png';
        },
        isValidImageUrl(url) {
            const pattern = new RegExp(`\\.(${this.allowedExtensions.join('|')})$`, 'i');
            try {
                new URL(url);
                return pattern.test(url);
            } catch (_) {
                return false;
            }
        },

        copyClipboard: function(text) {
            const input = document.createElement('input');
            input.value = text;
            document.body.appendChild(input);
            input.select();
            document.execCommand('copy');
            document.body.removeChild(input);
        },

        createHouse: function(house) {
            this.OpenModal(
                house ? app.translations.editHouse : app.translations.createHouse,
                `
                <div class="row mb-4 create-house">
                    <div class="col-12">
                        <h5 class="mt-4">${app.translations.houseName}</h5>
                        <input type="text" class="form-control w-100 input-house-name" placeholder="${app.translations.name}">
                    </div>
                    <div class="col-6">
                        <h5 class="mt-4">${app.translations.houseNumber}</h5>
                        <input type="number" min="000" max="999" class="form-control w-100 input-house-number" placeholder="${app.translations.number}">
                    </div>
                    <div class="col-6">
                        <h5 class="mt-4">${app.translations.housePrice}</h5>
                        <input type="number" class="form-control w-100 input-house-price" placeholder="${app.translations.price}">
                    </div>`+
                    (house ? '' : `
                        <h4 class="mt-4">${app.translations.houseType}</h4>
                        <div class="col-12 d-flex align-items-center justify-content-start house_types mt-2">
                            <div class="btn option" type="shell">
                                <i class="fa fa-house-chimney-window"></i>
                                <span>Shell</span>
                            </div>
                            <div class="btn option" type="ipl">
                                <i class="fa-solid fa-tent-arrows-down"></i>
                                <span>IPL</span>
                            </div>
                            <div class="btn option" type="mlo">
                                <i class="fa-solid fa-house"></i>
                                <span>MLO</span>
                            </div>
                        </div>
                        <div class="mt-4 col-12 int_categories">
                            <h4>${app.translations.interiors}</h4>
                            <span class="desc mb-2">${app.translations.defineInterior}</span>
                            <div class="d-flex align-items-center justify-content-start interior_categories mt-2">
                                <div class="btn option active" type="small">
                                    <i class="fa-solid fa-box-open"></i>
                                    <span>${app.translations.small}</span>
                                </div>
                                <div class="btn option" type="medium">
                                    <i class="fa-solid fa-house"></i>
                                    <span>${app.translations.medium}</span>
                                </div>
                                <div class="btn option" type="big">
                                    <i class="fa-solid fa-house-medical"></i>
                                    <span>${app.translations.big}</span>
                                </div>
                            </div>
                        </div>
                    `)+`
                    <div class="mt-4 col-12 payment-method">
                        <h4>${app.translations.paymentMethod}</h4>
                        <span class="desc">${app.translations.paymentMethodDesc}</span>
                        <div class="d-flex align-items-center justify-content-start payment-method mt-2">
                            ${Object.keys(app.paymentMethods).map((method) => `
                                <div class="btn option ${method == 'cash' ? 'active' : ''}" type="${method}">
                                    <i class="fa-solid fa-dollar-sign"></i>
                                    <span>${app.translations[method] || method}</span>
                                </div>
                            `).join('')}
                        </div>
                    </div>
                    ` + (!house ? `
                        <div class="construction-content mt-4">
                            <h4>${app.translations.constructionOptions}</h4>
                            <div class="col-12 mt-3">
                                <div class="check">
                                    <label class="switch">
                                        <input type="checkbox" class="check-construction">
                                        <span class="slider round"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="construction-options" style="display: none;">
                                <div class=" mt-3 ">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="box-option">
                                                <i class="fa-solid fa-clock"></i>
                                                <input type="number" min="000" max="999" class="w-100 input-construction-time" placeholder="${app.translations.time}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ` : '')+`

                    <div class="row mt-4">
                        <div class="col-6">
                            <h4>${app.translations.useGarage}</h4>
                            <span class="desc">${app.translations.useGarageDesc}</span>
                            <div class="check mt-2">
                                <label class="switch">
                                    <input type="checkbox" class="check-use-garage">
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>
                        <div class="col-6">
                            <h4>${app.translations.showOnMap}</h4>
                            <span class="desc">${app.translations.showOnMapDesc}</span>
                            <div class="check mt-2">
                                <label class="switch">
                                    <input type="checkbox" class="check-blip">
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="col-6 allow-vehicles mt-4">
                        <h4>${app.translations.allowVehicles}</h4>
                        <span class="desc mb-2">${app.translations.allowVehiclesDesc}</span>
                        <div class="check mt-2">
                            <label class="switch">
                                <input type="checkbox" class="check-allowvehicles">
                                <span class="slider round"></span>
                            </label>
                        </div>
                    </div>

                    <div class="row mt-4" style="display: ${house ? 'flex' : 'none'}">
                        <h5 class="mb-2">${app.translations.editOptions}</h5>
                        <div class="col-4 reposition-zone">
                            <h4>${app.translations.repositionZone}</h4>
                            <span class="desc mb-2">${app.translations.repositionZoneDesc}</span>
                            <div class="check mt-2">
                                <label class="switch">
                                    <input type="checkbox" class="check-reposition-zone">
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>

                        <div class="col-4 reposition-entry-point">
                            <h4>${app.translations.repositionEntryPoint}</h4>
                            <span class="desc mb-2">${app.translations.repositionEntryPointDesc}</span>
                            <div class="check mt-2">
                                <label class="switch">
                                    <input type="checkbox" class="check-reposition-entry-point">
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>

                        <div class="col-4 reposition-garage-point">
                            <h4>${app.translations.repositionGaragePoint}</h4>
                            <span class="desc mb-2">${app.translations.repositionGaragePointDesc}</span>
                            <div class="check mt-2">
                                <label class="switch">
                                    <input type="checkbox" class="check-reposition-garage-point">
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    ` + (house ? `
                        <div class="col-12 mt-4 holder-list">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="d-flex flex-column">
                                    <h4>${app.translations.holderList}</h4>
                                    <span class="desc mb-2">${app.translations.holderListDesc}</span>
                                </div>
                                <button class="btn-action danger" onclick="app.deleteAllHolders('${house.id}')">
                                    <i class="fas fa-trash"></i>
                                    <span>${app.translations.removeAll}</span>
                                </button>
                            </div>
                            <div class="holders-container mt-3">
                                ${(() => {
                                    const sortedHolders = Object.entries(house.holders).sort((a, b) => {
                                        if (a[1].owner) return -1;
                                        if (b[1].owner) return 1;
                                        return 0;
                                    });

                                    return sortedHolders.map(([citizenid, data]) => `
                                        <div class="holder-item d-flex align-items-center justify-content-between mb-2">
                                            <div class="d-flex align-items-center">
                                                <i class="fas ${data.owner ? 'fa-crown' : 'fa-user'} me-2"></i>
                                                <span class="holder-name">${data.name} - ${citizenid}</span>
                                            </div>
                                            <button class="btn-action danger" onclick="app.deleteHolder('${house.id}', '${citizenid}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    `).join('');
                                })()}
                            </div>
                        </div>
                    ` : '')+`
                </div>
                `, 
                `<button class="btn-modal" onclick='app.SaveHouse(${house ? true : false})'>${house ? app.translations.save : app.translations.accept}</button>`,
                app.translations.close,
                70
            );

            $(".check-construction").trigger('change');
            $('.house_types .btn.option').removeClass('active');
            $(`.house_types .btn.option[type="${house?.data?.type || this.creationData.data.type}"]`).addClass('active');
        
            if (house) {
                $('.input-house-name').val(house.name)
                $('.input-house-number').val(house.data.number)
                $('.input-house-price').val(house.data.price)
                $(".check-construction").prop('checked', house.construction.enabled);
                $('.interior_categories .btn.option').removeClass('active');
                $('.payment-method .btn.option').removeClass('active');
                $('.payment-method .btn.option[type='+house.data.paymentMethod+']').addClass('active');
                $('.interior_categories .btn.option[type='+(house.data.interior_category)+']').addClass('active');
                if (house.construction.enabled) {
                    $(".check-construction").trigger('change');
                    $('.input-construction-time').val(house.construction.time)
                }
                $(".check-use-garage").prop('checked', house.garage == 'none' ? false : true);
                $(".check-blip").prop('checked', house.data.showBlip);
                $(".check-allowvehicles").prop('checked', house.data.allowVehicles);
                this.creationData = house
            }
        },

        deleteHolder: function(houseID, citizenid) {
            TriggerCallback('origen_housing:server:editHolders', { houseID: houseID, citizenid: citizenid, action: 'delete' }).then((data) => {
                if (data === true) {
                    this.sendNotification('success', app.translations.holderDeleted, '', true);
                    this.CloseModal();
                    this.createHouse(this.houseList[houseID]);
                    // Scroll to bottom of the modal
                    setTimeout(() => {
                        const modal = document.querySelector('.modal-body');
                        modal.scrollTo({
                            top: modal.scrollHeight,
                            behavior: 'smooth'
                        });
                    }, 500);
                }
            });
        },

        deleteAllHolders: function(houseID) {
            TriggerCallback('origen_housing:server:editHolders', { houseID: houseID, action: 'deleteAll' }).then((data) => {
                if (data === true) {
                    this.sendNotification('success', app.translations.allHoldersDeleted, '', true);
                    this.CloseModal();
                }
            });
        },

        SaveHouse: function(house) {
            const name = $('.input-house-name').val();
            const price = parseFloat($('.input-house-price').val());
            const number = parseInt($('.input-house-number').val());
            const type = $('.create-house .house_types .option.active').attr('type');
            const interior_category = (type === 'shell' && $('.create-house .interior_categories .option.active').attr('type')) || false;
            const construction = (type !== 'mlo' && $('.check-construction').prop('checked')) || false;
            const construction_time = parseFloat($('.input-construction-time').val()) || 0; 
            const doors = [];
            const vehicles = (type !== 'mlo' && $('.check-allowvehicles').prop('checked')) || false;
            const blip = $('.check-blip').prop('checked');
            const minTime = Object.keys(this.stages).length
            const useGarage = $('.check-use-garage').prop('checked');
            const paymentMethod = $('.create-house .payment-method .option.active').attr('type');
        
            if (!house) {
                this.creationData.positions = {};
                this.creationData.exterior = {};
            }
        
            if (!name) {
                this.sendNotification('error', 'Error', this.translations.notyHouseNameNeed);
                return;
            }
        
            if (isNaN(price) || price < 0) {
                this.sendNotification('error', 'Error', this.translations.notyHousePriceNeed);
                return;
            }
        
            if (isNaN(number) || number < 0) {
                this.sendNotification('error', 'Error', this.translations.notyHouseNumberNeed);
                return;
            }
        
            if (construction) {
                if (isNaN(construction_time) || construction_time < minTime) {
                    this.sendNotification('error', 'Error', this.translations.notyHouseConstructionTimeNeed.replace('%s', minTime));
                    return;
                }
                this.creationData.construction.time = construction_time;
            }
        
            if (!house) {        
                this.creationData.data.interior_category = interior_category;
                this.creationData.data.type = type;
                
                this.creationData.doors = doors;
                this.creationData.construction.enabled = construction;
            }

            this.creationData.name = name;
            this.creationData.data.price = price;
            this.creationData.data.number = number;
            this.creationData.data.paymentMethod = paymentMethod;
            this.creationData.data.allowVehicles = vehicles;
            this.creationData.data.showBlip = blip;
            this.creationData.useGarage = useGarage;

            if (house) {
                const reposition = {
                    zone: $('.check-reposition-zone').prop('checked'),
                    entryPoint: $('.check-reposition-entry-point').prop('checked'),
                    garagePoint: $('.check-reposition-garage-point').prop('checked')
                }

                this.menu.management = false;
                this.CloseModal();
                fetch('close', {});

                TriggerCallback('origen_housing:server:editHouse', { house: this.creationData, reposition: reposition, houseID: this.creationData.id }).then((data) => {
                    if (data === true) {
                        this.sendNotification('success', this.translations.notyHouseEditedTitle, this.translations.notyHouseEditedMessage, true);
                    } else {
                        this.sendNotification('error', 'Error', data.message, true);
                    }
                });
                return;
            }

            this.menu.management = false;
            this.CloseModal();
            if (type == 'mlo') {
                TriggerCallback('origen_housing:server:createHouse', { house: this.creationData }).then((data) => {
                    if (data === true) {
                        this.sendNotification('success', this.translations.notyHouseCreatedTitle, this.translations.notyHouseCreatedMessage, true);
                    } else {
                        this.sendNotification('error', 'Error', data.message, true);
                    }
                });
            } else if (type == 'ipl' && !construction) {
                TriggerCallback('origen_housing:server:createHouse', { house: this.creationData }).then((data) => {
                    if (data === true) {
                        this.sendNotification('success', this.translations.notyHouseCreatedTitle, this.translations.notyHouseCreatedMessage, true);
                    } else {
                        this.sendNotification('error', 'Error', data.message, true);
                    }
                });
            } else {
                if (construction) {
                    this.previewOptions(this.exteriors, 'exteriors', app.translations.selectExterior, true);
                } else {
                    if (!house) {
                        let items = [];
                        let path  = '';
                        let title = '';
                        switch(type) {
                            case 'shell':
                                const shellCategories = interior_category || 'small';
                                path = 'shell';
                                title = app.translations.selectShell;
                                items = this.shells[shellCategories];
                            break;
                        }
        
                        this.previewOptions(items, path, title);
                    } else {
                        TriggerCallback('origen_housing:server:createHouse', { house: this.creationData }).then((data) => {
                            if (data === true) {
                                this.sendNotification('success', this.translations.notyHouseCreatedTitle, this.translations.notyHouseCreatedMessage, true);
                            } else {
                                this.sendNotification('error', 'Error', data.message, true);
                            }
                        });
                    }
                }
            }
        },
        buyHouse: function(house, garage) {
            const houseID = house.id;
            const interior_category = house.data.interior_category;
            const houseModel = house.data.model;
            let houseData = false;

            if (house.data.type === 'ipl') {
                houseData = this.ipls[houseModel];
            } else if (house.data.type === 'shell' && this.shells[interior_category] && this.shells[interior_category][houseModel]) {
                houseData = this.shells[interior_category][houseModel];
            }

            this.buyMenu = true;
            this.currentModal = this.OpenModal(
                this.translations.BuyHouseTitle,
                `
                <div class="buy-house d-flex align-items-center row">
                    <div class="col-12">
                        <div class="box-option">
                            <i class="fa-solid fa-circle-info"></i>
                            <div class="info d-flex flex-column">
                                <h5>${this.translations.PropertyName}</h5>
                                <span>${house.name || 'Test'}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="box-option">
                            <i class="fa-solid fa-dollar-sign"></i>
                            <div class="info d-flex flex-column">
                                <h5>${this.translations.PropertyPrice}</h5>
                                <span style="color: #42af72;">$${house.data.price}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="box-option">
                            <i class="fa-solid fa-hashtag"></i>
                            <div class="info d-flex flex-column">
                                <h5>${this.translations.PropertyNumber}</h5>
                                <span>${house.data.number}</span>
                            </div>
                        </div>
                    </div>

                    ${garage ? `
                        <h4 class="mt-4">${this.translations.PropertyGarageTitle}</h4>
                        <div class="col-6">
                            <div class="box-option">
                                <i class="fa-solid fa-warehouse"></i>
                                <div class="info d-flex flex-column">
                                    <h5>${this.translations.PropertyClassification}</h5>
                                    <span>Small</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="box-option">
                                <i class="fa-solid fa-square-parking"></i>
                                <div class="info d-flex flex-column">
                                    <h5>${this.translations.PropertyGarageSlots}</h5>
                                    <span>${garage.slots.length}</span>
                                </div>
                            </div>
                        </div>
                        ${garage.images ? `
                            <div class="d-flex align-items-center w-100 garage-images mt-4">
                                ${garage.images.map((image) => `
                                    <div class="house-image">
                                        <img src="./img/garages/`+ image +`">
                                    </div>
                                `).join('')}
                            </div>
                        ` : ''}
                    ` : ''}
                </div>
                `,
                `<div class="d-flex align-items-center">
                    <button class="btn-modal" onclick="app.buyHouseConfirm('${houseID}')">${this.translations.BuyHouse}</button>
                    ${house.data.type !== 'mlo' ? `
                        <button class="btn-modal visit-btn" style="margin-left: 1vh;" onclick="app.visitHouse('${houseID}')">${this.translations.visitHouse}</button>
                    ` : ''}
                </div>`,
                this.translations.Close,
                55
            );
            this.currentModal = 'buyHouse';
        },

        closeBuyHouse: function() {
            fetch('closeBuyHouse', {});
        },

        visitHouse: function(houseID) {
            fetch('visitHouse', { houseID: houseID }).then((data) => {
                if (data) this.CloseModal();
            });
        },

        buyHouseConfirm: function(houseID) {
            this.currentModal = 'buyHouseConfirm';
            this.OpenModal(
                app.translations.confirmBuyHouse,
                `<p style="font-size: 2.5vh;">${app.translations.buyHouseConfirm}</p>`,
                `<button class="btn-modal" onclick="confirmPurchase()">${this.translations.BuyHouse}</button>`,
                this.translations.Close,
                55
            );

            window.confirmPurchase = function() {
                TriggerCallback('origen_housing:server:buyHouse', { houseID: houseID }).then((data) => {
                    if (data === true) {
                        app.sendNotification('success', app.translations.buyHouseSuccess, '', true);
                        app.CloseModal();
                    } else {
                        app.sendNotification('error', 'Error', data.message, false);
                    }
                });
            };
        },

        markPosition: function(houseID, event) {
            event.stopPropagation();
            fetch('markHousePosition', {
                id: houseID
            }).then((data) => {
                if (data) {
                    this.sendNotification('success', app.translations.markPosition, '', true);
                } else {
                    this.sendNotification('error', app.translations.errorMarkPosition, '', true);
                }
            })
        },

        togglePreviewOpacity: function (state) {
            this.menu.preview.hidden = state;
        },
        
        previewOptions: function(items, path, title) {
            if (!items) return;
            this.menu.preview.visible = true;
            this.menu.preview.items = items;
            this.menu.preview.title = title;
            this.menu.preview.path = path;
            this.menu.preview.itemLength = typeof items === 'object' ? Object.keys(items).length : items.length;

            if (this.swiper) {
                this.swiper.destroy();
            }

            if (path == 'exteriors' || path == 'shell') {
                this.ControlsNotify([
                    {key: 'E', text: this.translations.view},
                    {key: 'ENTER', text: this.translations.confirm}
                ])
            }

            this.$nextTick(() => {
                this.swiper = new Swiper('.creation-selector .slider-preview', {
                    freeMode: false,
                    autoplay: false,
                    slidesPerView: this.menu.preview.itemLength > 3 ? 3 : 1,
                    spaceBetween: 10,
                    centeredSlides: false,
                    mousewheel: true,
                    speed: 500,
                    keyboard: {
                        enabled: true,
                        onlyInViewport: true,
                        pageUpDown: false,
                    },
                    grabCursor: true,
                    loop: this.menu.preview.itemLength > 3 ? true : false,
                    navigation: {
                        nextEl: '.next',
                        prevEl: '.prev',
                    },
                });
                
                const startIndex = 1;
                const startItem = this.menu.preview.items[1];

                if (path == 'shell') {
                    $('.creation-selector .slider-preview .swiper-slide.slide-' + startIndex).addClass('selected');
                    this.selectedShell = startItem.model;
                } else if (path == 'exteriors') {
                    $('.creation-selector .slider-preview .swiper-slide.slide-' + startIndex).addClass('selected');
                    this.selectedExterior = startItem.model;
                }

                this.swiper.on('slideChange', () => {
                    const realIndex = (this.swiper.realIndex + 1) % this.swiper.slides.length;
                    $('.creation-selector .slider-preview .swiper-slide').removeClass('selected');
                    $('.creation-selector .slider-preview .swiper-slide.slide-' + realIndex).addClass('selected');
                    
                    const item = this.menu.preview.items[realIndex];

                    if (!item) {
                        return;
                    }

                    if (path == 'shell') {
                        if (!this.selectedShell) {
                            this.selectedShell = item.model;
                        } else if (this.selectedShell != item.model) {
                            this.selectedShell = item.model;
                        }
                    } else if (path == 'exteriors') {
                        if (!this.selectedExterior) {
                            this.selectedExterior = item.model;
                        } else if (this.selectedExterior != item.model) {
                            this.selectedExterior = item.model;
                        }
                    }
                });

                this.swiper.on('keyPress', (_, keyCode) => {
                    if (keyCode == 13) {
                        this.controlsHelp.visible = false;
                        if (!this.menu.preview.visible || !this.swiper) return;
                        const realIndex = (this.swiper.realIndex + 1) % this.swiper.slides.length;
                        const item = this.menu.preview.items[realIndex];

                        if (!item) return;

                        switch (this.menu.preview.path) {
                            case 'exteriors':
                                this.closePreview();
                                this.creationData.construction.model = item.model;
                                fetch('startConstructionPlacement', {
                                    house: this.creationData
                                }).then((data) => {
                                    const constructionCoords = data.constructionCoords;
                                    const polyzoneCoords = data.polyzoneCoords;
                                    const entryCoords = data.entryCoords;
                                    const garageCoords = data.garageCoords;
                                    this.creationData.construction.coords = constructionCoords;
                                    this.creationData.exterior = polyzoneCoords;
                                    this.creationData.positions.entry = entryCoords;
                                    
                                    if (this.creationData.useGarage) {
                                        this.creationData.positions.garage = garageCoords;
                                    }

                                    if (this.creationData.data.type === 'shell') {
                                        this.previewOptions(this.shells[this.creationData.data.interior_category], 'shell', this.translations.selectShell);
                                        return;
                                    } else {
                                        TriggerCallback('origen_housing:server:createHouse', { house: this.creationData }).then((data) => {
                                            if (data === true) {
                                                this.sendNotification('success', this.translations.notyHouseCreatedTitle, this.translations.notyHouseCreatedMessage, true);
                                            } else {
                                                this.sendNotification('error', 'Error', data.message, true);
                                            }
                                        });
                                    }
                                });
                            break;
                            case 'shell':
                                this.creationData.data.model = item.model;
                                this.closePreview();
                                TriggerCallback('origen_housing:server:createHouse', { house: this.creationData }).then((data) => {
                                    if (data === true) {
                                        this.sendNotification('success', this.translations.notyHouseCreatedTitle, this.translations.notyHouseCreatedMessage, true);
                                    } else {
                                        this.sendNotification('error', 'Error', data.message, true);
                                    }
                                });
                            break;
                        }
                    } else if (keyCode == 69) {
                        if (this.selectedShell) {
                            fetch('previewShell', { model: this.selectedShell });
                            this.selectedShell = null;
                        } else if (this.selectedExterior) {
                            fetch('previewExterior', { model: this.selectedExterior });
                            this.selectedExterior = null;
                        }
                    }
                });
            });
        },
        closePreview: function() {
            setTimeout(() => {
                if ( this.swiper) {
                    this.swiper.destroy();
                    this.swiper = null;
                }
            }, 500);
            this.menu.preview.visible = false;
            this.menu.preview.items = [];
            this.menu.preview.title = ''; 
        },
        ToggleManagement: function(state) {
            if (state) {
                this.menu.management = true;
                s_transition.currentTime = '0'; 
                s_transition.play();
            } else {
                this.menu.management = false;
            }
        },
        ControlsNotify: function(keys, title) {
            this.controlsHelp.visible = true;
            this.controlsHelp.keysData = keys;
            this.controlsHelp.title = title ? title : false;
        },
        sendNotification: function(type, title, message, custom) {

            if (custom) {
                fetch('sendNotification', {
                    type: type,
                    title: title,
                    message: message,
                });
                return;
            }

            let id = Math.floor(Math.random() * 10000);
            let icon = type == 'success' ? 'fas fa-check' : type == 'error' ? 'fas fa-times' : 'fas fa-bell';
            
            this.notifications.push({
                id: id,
                type: type,
                icon: icon,
                title: title,
                message: message || '',
            })

            setTimeout(function () {
                $(`#${id}`)
                    .removeClass('animate__bounceInDown')
                    .addClass('animate__bounceOutUp')
                    .fadeOut(500, function () {
                        $(this).remove();
                        app.notifications.splice(app.notifications.findIndex((item) => item.id == id), 1);
                    });
            }, 3000);
        },
        OpenModal: function(title, content, footerButtons, closeText, width) {
            const id = this.modals.length + 1;
            this.modals.push(id);
            $('.modals').append(`
                <div class="c-modal fadeIn" data-id="${id}">
                    <div class="modal-block">
                        <div class="modal-content scale-in-2" style="width: ${
                            width ? width + 'vh' : 'max-content'
                        }">
                            <div class="modal-header">

                                <h2 class="title">${title}</h2>
                            </div>
                            <div class="modal-body">
                                ${content}
                            </div>
                            <div class="modal-footer">
                                ${footerButtons}
                                <button class="btn-cancel" onclick='app.CloseModal(${id})'>${closeText}</button>
                            </div>
                        </div>
                    </div>
                </div>
            `);
            return id;
        },
        CloseModal: function(id) {
            if (!id) {
                $('.c-modal .modal-block .modal-content').removeClass('scale-in-2').addClass('scale-out-2');
                $('.c-modal').removeClass('fadeIn').fadeOut(500, function () {
                    $(this).remove();
                    $('.o-modal').hide()
                    app.modals = [];
                });

                if (this.buyMenu) {
                    this.closeBuyHouse();
                    this.buyMenu = false;
                }
            } else {
                $(`.c-modal[data-id='${id}']`).find('.modal-content').removeClass('scale-in-2').addClass('scale-out-2');
                $(`.c-modal[data-id='${id}']`).removeClass('fadeIn').fadeOut(500, function () {
                    $(this).remove();
                    app.modals.splice(app.modals.findIndex((item) => item == id), 1);
                    if ($('.c-modal').length === 0) {
                        $('.o-modal').hide();
                        app.modals = [];
                    }
                });
            }

            if (this.currentModal === 'buyHouse' && this.buyMenu) {
                this.closeBuyHouse();
                this.buyMenu = false;
            } else if (this.currentModal === 'buyHouseConfirm' && this.buyMenu) {
                this.currentModal = 'buyHouse';
            } else if (this.currentModal == 'confirmBuyFurniture') {
                fetch('cancelFurniturePurchase', {});
                this.currentModal = null;
                this.furniture.selectedEntity = false;
            }
        },

        deleteHouse: function(id) {

            this.currentModal = 'deleteHouse';
            this.OpenModal(
                app.translations.confirmDeleteHouseTitle,
                `<p style="font-size: 2.5vh;">${app.translations.confirmDeleteHouse}</p>`,
                `<button class="btn-modal" onclick="confirmDelete()">${this.translations.confirm}</button>`,
                this.translations.Close,
                50
            );

            window.confirmDelete = function() {
                TriggerCallback('origen_housing:server:deleteHouse', { id: id }).then((data) => {
                    if (data === true) {
                        this.sendNotification('success', this.translations.notyHouseDeletedTitle, this.translations.notyHouseDeletedMessage, true);
                        Vue.delete(this.houseList, id);
                    } else {
                        this.sendNotification('error', this.translations.notyHouseDeleteError, data.message, true);
                    }
                });
            };
        },

        changeHouseTab: function(tab) {
            if (tab == this.house.currentTab) return;
            this.house.currentTab = tab;
            this.loadHouseSwiper();
        },

        loadHouseSwiper: function(close) {
            if (close) {
                if (this.house.swiper) {
                   this.house.swiper.destroy(); 
                    this.house.swiper = null;
                }
                return;
            };

            if (this.house.swiper) {
                this.house.swiper.destroy(); 
            }

            this.$nextTick(() => {
                if (this.house.currentTab === 'upgrades') {
                    this.house.swiper = new Swiper('.upgrade_panel .slider-preview.tab-upgrades', {
                        freeMode: false,
                        autoplay: {
                            delay: 5000,
                            disableOnInteraction: true,
                        },           
                        slidesPerView: 3,
                        spaceBetween: 10,
                        centeredSlides: true,
                        mousewheel: true,
                        speed: 500,
                        keyboard: true,
                        grabCursor: true,
                        loop: true,
                        navigation: {
                            nextEl: '.next',
                            prevEl: '.prev',
                        },
                        effect: 'coverflow',
                        coverflowEffect: {
                            rotate: 0,
                            stretch: 0,
                            depth: 100,
                            modifier: 1,
                            slideShadows: true
                        }
                    });
                    this.house.swiper.on('slideChange', () => {
                        const realIndex = (this.house.swiper.realIndex) % this.house.swiper.slides.length;
    
                        $('.upgrade_panel .tab-upgrades .slider-preview .swiper-slide').removeClass('selected');
                        $('.upgrade_panel .tab-upgrades .slider-preview .swiper-slide.slide-' + realIndex).addClass('selected');
    

                        if (this.ipls[this.house.data.data.model].list[realIndex].name == this.house.data.data.style) {
                            this.house.currentUpgrade = null;
                            return;
                        }

                        this.house.currentUpgrade = realIndex;
                    });
                } else if (this.house.currentTab === 'cameras' && !this.house.upgrades.cameras.locked) {
                    this.house.swiper = new Swiper('.upgrade_panel .slider-preview.tab-cameras', {
                        freeMode: false,
                        slidesPerView: 5,
                        grid: {
                          rows: 2,
                        },
                        spaceBetween: 10,
                    });
                }
            });
        },

        showHousePanel: function(data) {
            s_transition.currentTime = '0';
            s_transition.play();

            if (data.state) {
                if (this.menu.houses.visible) {
                    this.ToggleHousesMenu(false, false, false);
                }
                
                this.house.visible = true;
                this.house.data = data.data;
                this.house.currentUpgrade = null;

                this.house.data.emptyCameras = Math.max(0, 10 - Object.keys(this.house.data.cameras).length);

                this.house.data.lightsCount = Object.keys(this.house.data.lights).length;
                this.house.data.boardsCount = Object.keys(this.house.data.boards).length;

                this.house.data.emptyLights = Math.max(0, 5 - this.house.data.lightsCount);
                this.house.data.emptyBoards = Math.max(0, 6 - this.house.data.boardsCount);
                
                for (const key in this.house.upgrades) {
                    if (this.house.data.settings.upgrades[key]) {
                        this.house.upgrades[key].locked = false;
                    } else {
                        this.house.upgrades[key].locked = true;
                    }
                }
                
                if (this.house.data.data.type === 'ipl' && this.house.data.data.style && this.ipls[this.house.data.data.model]) {
                    this.house.currentTab = 'upgrades';
                }

                this.loadHouseSwiper();
            } else {
                this.house.visible = false;
                fetch('close', {});
                this.CloseModal();
                this.buyUpgrade(false);
                this.notifications = [];
                this.currentUpgrade = null;
                setTimeout(() => {
                    if (this.house.visible) return;
                    if (this.house.swiper) {
                        this.house.swiper.destroy(); 
                        this.house.swiper = null;
                    }
                }, 500);
            }
        },

        deleteKey: function(citizenid) {
            const id = this.house.data.id;
            TriggerCallback('origen_housing:server:deleteKey', { citizenid: citizenid, houseID: id }).then((data) => {
                if (data === true) {
                    this.sendNotification('success', app.translations.deleteKey);
                    delete this.house.data.holders[citizenid];
                } else {
                    this.sendNotification('error', data.message);
                }
            });
        }, 

        loadNearbyPlayers: async function() {
            let nearbyPlayers = '';
            const data = await TriggerCallback('origen_housing:server:getNearbyPlayers', {});
        
            if (data && data.length > 0) {
                for (const player of data) {
                    if (!this.house.data.holders[player.citizenid]) {
                        nearbyPlayers += `
                            <div class="col-12 mt-2">
                                <div class="box-option btn" onclick="app.addKey('${player.citizenid}', '${player.name}', '${player.id}')">
                                    <i class="fa-solid fa-user"></i>
                                    <span style="margin-left: 1vh;">${player.name}</span>
                                </div>
                            </div>
                        `;
                    }
                }
            }
        
            if (nearbyPlayers === '') {
                nearbyPlayers = `
                    <div class="col-12 mt-2">
                        <div class="box-option">
                            <i class="fa-solid fa-user"></i>
                            <span style="margin-left: 1vh;">${app.translations.noNearbyPlayers}</span>
                        </div>
                    </div>
                `;
            }
        
            return nearbyPlayers;
        },
        
        addKeyModal: async function() {
            const nearbyPlayers = await this.loadNearbyPlayers();
        
            this.OpenModal(
                app.translations.addKeyLabel,
                `<div class="row mb-2 nearby-players">${nearbyPlayers}</div>`,
                `<button class="btn-modal" onclick="app.reloadNearbyPlayers()">${this.translations.reload}</button>`,
                this.translations.Close,
                55
            );
        },
        
        reloadNearbyPlayers: async function() {
            const nearbyPlayers = await this.loadNearbyPlayers();
        
            if (!nearbyPlayers) return;
        
            const container = document.querySelector('.nearby-players');
        
            container.innerHTML = nearbyPlayers;
        },
        

        addKey: function(citizenid, name, targetID) {
            TriggerCallback('origen_housing:server:giveKey', { 
                citizenid: citizenid, name: name, houseID: this.house.data.id , targetID: targetID
            }).then((data) => {
                if (data === true) {
                    this.sendNotification('success', app.translations.addKey);
                    this.house.data.holders[citizenid] = {
                        name: name,
                        owner: false,
                    };
                    this.CloseModal();
                } else {
                    this.sendNotification('error', 'Error', data.message);
                }
            })
        },

        toggleLock: function(doorID) {
            const houseID = this.house.data.id;
            TriggerCallback('origen_housing:server:toggleLock', { doorID: doorID, houseID: houseID }).then((data) => {
                if (data.status === true) {
                    const state = data.locked ? app.translations.locked : app.translations.unlocked;
                    this.sendNotification('success', app.translations.door + ' ' + state, app.translations.toggleDoor.replace('%s', state));
                    this.house.data.doors[doorID].locked = !this.house.data.doors[doorID].locked;
                } else {
                    this.sendNotification('error', 'Error', data.message);
                }
            });
        },

        deleteDoor: function(doorID) {
            const houseID = this.house.data.id;

            TriggerCallback('origen_housing:server:deleteDoor', { 
                doorID: doorID, 
                houseID: houseID 
            }).then((data) => {
                if (data === true) {
                    this.house.data.doors[doorID] = null;
                    delete this.house.data.doors[doorID];
                } else {
                    this.sendNotification('error', 'Error', data.message);
                }
            });
        },

        createDoor: function() {
            fetch('canCreateDoor', { houseID: this.house.data.id }).then((data) => {
                if (data === true) {
                    this.currentModal = this.OpenModal(
                        app.translations.addDoor,
                        `
                        <div class="row mb-4 create-door">
                            <div class="col-12">
                                <h5 class="mt-4">${app.translations.doorName}</h5>
                                <input type="text" class="form-control w-100 input-door-name" placeholder="${app.translations.name}">
                            </div>
                            <h5 class="mt-4">${app.translations.doorType}</h5>
                            <div class="col-12 d-flex align-items-center justify-content-start door_types">
                                <div class="btn option active btn-sound" type="normal">
                                    <i class="fa fa-house-chimney-window"></i>
                                    <span>${app.translations.normal}</span>
                                </div>
                                <div class="btn option btn-sound" type="double">
                                    <i class="fa fa-house-chimney-window"></i>
                                    <span>${app.translations.double}</span>
                                </div>
                                <div class="btn option btn-sound" type="garage">
                                    <i class="fa-solid fa-tent-arrows-down"></i>
                                    <span>${app.translations.garage}</span>
                                </div>
                            </div>
                        </div>
                        `, 
                        `<button class="btn-modal" onclick="SaveDoor()">${app.translations.confirm}</button>`,
                        'Cerrar',
                        50
                    );
        
                    window.SaveDoor = function() {
                        const name = $('.input-door-name').val();
                        const type = $('.create-door .door_types .option.active').attr('type');
        
                        if (!name || name.length < 5) {
                            app.sendNotification('error', 'Error', app.translations.enterName);
                            return;
                        }
        
                        fetch('createDoor', { name: name, type: type }).then((data) => {
                            if (data) {
                                app.CloseModal(app.currentModal);
                            } else {
                                app.sendNotification('error', 'Error', app.translations.errorCreateDoor);
                            }
                        })
                    };
                } else {
                    app.sendNotification('error', 'Error', app.translations.errorCreateDoor);
                }
            });
        },

        useCamera: function(cameraID) {
            const houseID = this.house.data.id;

            if (!houseID || !cameraID) return;

            fetch('useCamera', { cameraID: cameraID, houseID: houseID })
        },
        
        // Furniture
        toggleFurnitureMenu: function(state, force) {
            if (state) {
                app.currentModal = null;
                this.furniture.selectCategory = null;
                this.furniture.minimized = false;
                this.furniture.action = 'move';
                fetch('backCategory', {});
            }
            this.furniture.visible = state;
            this.furniture.selectedEntity = false;

            if (!state && !force) {
                this.furniture.selectCategory = null;
                this.furniture.minimized = false;
            }
        },

        editObject: function(index) {
            event.stopPropagation();
            fetch('onActionObject', {
                action: 'edit',
                id: index,
            }).then((entity) => {
                this.furniture.selectedEntity = entity;
                this.furniture.isMoving = true;
                s_pop.currentTime = '0';
                s_pop.play();
            });
        },
        deleteObject: function(index) {
            event.stopPropagation();
            fetch('onActionObject', {
                action: 'delete',
                id: index,
            });
        },

        selectObject: function(index) {
            this.furniture.selectedObject = index
            fetch('onActionObject', {
                action: 'select',
                id: index,
            });
        },

        openFurnitureMenu: function() {
            fetch('openFurnitureMenu', {});
        },

        toggleFurnitureMode: function() {
            if (!this.furniture.visible) return;

            this.furniture.mode = this.furniture.mode === 'gizmo' ? 'mouse' : 'gizmo';

            fetch('toggleFurnitureMode', {mode: this.furniture.mode});
        },

        backCategory: function() {
            this.furniture.selectCategory = null;
            this.furniture.minimized = false;
            this.furniture.action = 'move';

            fetch('backCategory', {});
        },

        selectFurnitureCategory: function(category) {

            if (this.furniture.selectCategory === category) {
                this.furniture.selectCategory = null;
                this.furniture.currentObject = false;
                this.furniture.minimized = false;
                this.furniture.action = 'move';
                fetch('backCategory', {});
                return;
            }
            this.furniture.selectCategory = category;
            this.furniture.minimized = true;
            this.furniture.action = 'create';
            fetch('selectCategory', {});
        },
        spawnObject: function(model) {
            fetch('spawnObject', { model: model})
            .then((spawned) => {
                this.furniture.currentObject = spawned;
            });
        },
        startPlacement: function() {
            fetch('startPlacement', {});
            this.toggleFurnitureMenu(false, true);
        },
        confirmBuyFurniture: function() {
            if (this.furniture.selectCategory == null || !this.furniture.currentObject) {
                return;
            }

            fetch('stopPlacement', {});

            const object = this.furniture.currentObject;

            const item = this.furniture.items[this.furniture.selectCategory].items.filter((item) => item.model === object);

            if (!item) return;

            const price = !item[0].price ? this.furniture.defaultPrice > 0 ? '$' + this.furniture.defaultPrice : app.translations.free : item[0].price > 0 ? '$' + item[0].price : app.translations.free;

            const showModal = localStorage.getItem('confirmBuyFurniture');

            if (showModal === 'false') {
                fetch('confirmBuyFurniture', {}).then((data) => {
                    if (data === true) {
                        this.CloseModal();
                    }
                    fetch('cancelFurniturePurchase', {});
                    this.furniture.currentObject = false;
                });
                return;
            }

            this.OpenModal(
                app.translations.confirmBuyFurniture,
                `<div class="row mb-2 confirm-buy-object">
                    <h5 class="mt-4">${app.translations.buyObjectDesc}</h5>

                    <div class="d-flex align-items-center justify-content-center w-100 mt-4">
                        <div class="object">
                            <span class="price">${price}</span>
                            <img src="./img/furniture/${object}.png" onerror="javascript:this.src='./img/default.png'">
                        </div>
                    </div>

                    <div class="mt-4 d-flex align-items-center">
                        <label class="checkbox">
                            <input type="checkbox" id="showAgain">
                            <div class="transition"></div>
                        </label>
                        <span class="desc">${app.translations.showAgain}</span>
                    </div>
                </div>`,
                `<button class="btn-modal" onclick="confirmFurniturePurchase()">${app.translations.confirm}</button>`,
                this.translations.Close,
                55
            );

            this.currentModal = 'confirmBuyFurniture';

            window.confirmFurniturePurchase = function() {
                const showAgain = document.getElementById('showAgain').checked;

                if (showAgain) {
                    localStorage.setItem('confirmBuyFurniture', 'false');
                }

                fetch('confirmBuyFurniture', {}).then((data) => {
                    if (data === true) {
                        app.CloseModal();        
                    }
                    app.furniture.currentObject = false;
                });
            };
        },

        // Upgrades

        tryBuyUpgrade: function(upgrade) {

            if (!this.house.upgrades[upgrade] || !this.house.upgrades[upgrade].locked) {
                return;
            }

            const id = this.house.data.id;

            this.OpenModal(
                app.translations.buyUpgrade,
                `<div class="row mb-2 confirm-buy-object">
                    <h4 class="mt-4">${app.translations.buyUpgradeDesc}</h4>
                </div>`,
                `<button class="btn-modal" onclick="confirmUpgradePurchase('${upgrade}')">${app.translations.confirm}</button>`,
                this.translations.Close,
                55
            );

            window.confirmUpgradePurchase = function(upgrade) {
                TriggerCallback('origen_housing:server:buyUpgrade', { upgrade: upgrade, houseID: id }).then((data) => {
                    if (data === true) {
                        app.sendNotification('success', app.translations.buyUpgradeSuccess);
                        app.CloseModal();
                        app.buyUpgrade(true, upgrade);
                        app.house.upgrades[upgrade].locked = false;
                    } else {
                        app.sendNotification('error', 'Error', data.message);
                    }
                });
            }
        },

        buyUpgrade: function(state, upgrade, title) {
            if (state) {
                this.upgrades.item = upgrade;
                if (upgrade !== 'house' && !this.house.upgrades[upgrade].locked) {
                    return;
                }

                this.upgrades.visible = true;
                this.upgrades.interval = setInterval(() => {
                    confetti({
                        particleCount: 2,
                        angle: 50,
                        spread: 360,
                        origin: { x: 0, y: 0.5 },
                        colors: ['#850E49F2', '#ACACAC'],
                    });
                    confetti({
                        particleCount: 2,
                        angle: 150,
                        spread: 360,
                        origin: { x: 1, y: 0.5 },
                        colors: ['#850E49F2', '#ACACAC']
                    });
                }, 20);
                if (upgrade === 'house') {
                    this.upgrades.title = title;
                } else {
                    this.upgrades.title = this.house.upgrades[upgrade].label;
                }

                if (upgrade === 'cameras' && this.house.currentTab === 'cameras') {
                    this.loadHouseSwiper();
                }

                s_unlock.currentTime = '0';
                s_unlock.play();
            } else {
                if (this.upgrades.interval) {
                    confetti.reset();
                    clearInterval(this.upgrades.interval);
                }
                this.upgrades.visible = false;
                this.upgrades.item = '';
                this.upgrades.title = '';
            }
        },

        buyHouseUpgrade: function() {
            if (this.house.currentUpgrade === null) return;
            const houseID = this.house.data.id
            const style = this.house.currentUpgrade;
            TriggerCallback('origen_housing:server:buyHouseUpgrade', { houseID: houseID, style: style }).then((data) => {
                if (data.status === true) {
                    this.house.data.data.style = data.style;
                    this.sendNotification('success', app.translations.buyHouseUpgradeSuccess);
                } else {
                    this.sendNotification('error', 'Error', data.message);
                }
            });
        },

        openLightMenu: function(id, event) {
            if (!this.house.data.lights[id]) return;
            this.currentLight = id;
        },
    
        toggleLight: function(id, event) {
            event.stopPropagation();
            const houseID = this.house.data.id;
            if (!houseID) return;
            this.house.data.lights[id].state = !this.house.data.lights[id].state;
            TriggerCallback('origen_housing:server:UpdateLight', { houseID: houseID, lightID: id, state: this.house.data.lights[id].state });
        },

        closeLightMenu: function() {
            this.currentLight = null;
            this.isEditingName = false;
            this.editedName = '';
        },

        selectColor: function(color) {
            this.house.data.lights[this.currentLight].color = color;
        },

        isColorSelected(color) {
            return this.house.data.lights[this.currentLight].color.every((value, index) => value === color[index]);
        },

        saveLightChanges: function() {
            const houseID = this.house.data.id;
            if (!houseID) return;

            const color = this.house.data.lights[this.currentLight].color;
            const opacity = this.house.data.lights[this.currentLight].opacity;
            const state = this.house.data.lights[this.currentLight].state;
            const label = this.editedName !== '' ? this.editedName : false;

            if (label && label.length < 5) {
                this.sendNotification('error', 'Error', app.translations.notyHouseNameNeedLength);
                return;
            }
  
            TriggerCallback('origen_housing:server:UpdateLight', { 
                houseID: houseID,
                lightID: this.currentLight,
                color: color,
                opacity: opacity,
                state: state,
                label: label
            }).then((data) => {
                if (data === true) {
                    this.sendNotification('success', app.translations.lightUpdated);
                    if (label) {
                        this.house.data.lights[this.currentLight].label = label;
                    }
                } else {
                    this.sendNotification('error', 'Error', data.message);
                }
            });
        },

        startEditingName: function() {
            this.editedName = this.house.data.lights[this.currentLight].label;
            this.isEditingName = true;
        },
    
        finishEditingName: function() {
            this.isEditingName = false;
        },

        handleBlur(id) {
            this.saveBoardUrl(id);
        },
        saveBoardUrl(id, event) {
            const houseID = this.house.data.id;
            if (!houseID) return;

            if (event && event.type === 'keyup') {
                event.target.blur();
                return;
            }
    
            const item = this.house.data.boards[id];

            if (!item) return;

            if (this.newUrl == item.url || !isNaN(this.newUrl)) {
                this.isEditingURL = null;
                return;
            }

            if (this.isValidImageUrl(this.newUrl)) {
                TriggerCallback('origen_housing:server:UpdateBoard', {
                    houseID: houseID,
                    boardID: id,
                    url: this.newUrl
                }).then((data) => {
                    if (data === true) {
                        this.sendNotification('success', app.translations.boardUpdated);
                        item.url = this.newUrl;
                    } else {
                        this.sendNotification('error', 'Error', data.message);
                    }
                    this.newUrl = '';
                });
            } else {
                this.sendNotification('error', app.translations.invalidUrl, app.translations.enterValidUrl);
                this.newUrl = '';
            }
            this.isEditingURL = null;
        },

        PlayAlarm: function() {
            alarm.loop = true;
            alarm.play();
        },
        UpdateAlarm: function(volume) {
            if (volume > 1) volume = 0.7;
            if (volume < 0.015) volume = 0;

            alarm.volume = volume;
        },
        StopAlarm: function() {
            alarm.pause();
            alarm.currentTime = 0;
        },

        ToggleHousesMenu: function(state, houses, focus) {
            if (!state) {
                this.menu.houses.visible = false;
                if (focus) {
                    fetch('close', {});
                }
                return;
            }

            if (state && this.menu.houses.visible && Object.keys(houses).length == 0) {
                return;
            }

            this.menu.houses.visible = true;
            this.menu.houses.list = houses;
            
            if (!focus) {
                setTimeout(() => {
                    if (Object.keys(this.menu.houses.list).length > 0) return;

                    this.menu.houses.visible = false;
                }, 3000);
            }
        },

        loadHouse: function(houseID) {
            fetch('loadHouse', {
                id: houseID
            });
        },

        toggleElevator: function(data) {
            this.elevator.visible = data.state;

            if (data.state) {
                this.elevator.floors = data.data.floors;
                this.elevator.currentFloor = data.data.floor;
            }
        },

        selectFloor: function(floor) {
            this.elevator.currentFloor = floor;
            fetch('selectFloor', {
                floor: floor
            });
        },

        handleOnKeyUp: function(event) {
            event.preventDefault();
            event.stopPropagation();

            if (event.which == 27) {
                if (this.menu.management) {
                    this.ToggleManagement(false);
                    this.CloseModal();
                    fetch('closeMenu', {});
                } else if (this.house.visible) {
                    this.showHousePanel({
                        state: false,
                    });
                    this.upgrades.info.visible = false;
                } else if (this.furniture.visible) {
                    this.toggleFurnitureMenu(false);
                    fetch('closeFurniture', {});
                    this.furniture.isMoving = false;
                    this.gizmoMode = false;
                } else if (this.buyMenu) {
                    this.CloseModal();
                    this.closeBuyHouse();
                } else if (this.menu.houses.visible) {
                    this.ToggleHousesMenu(false, false, true);
                } else if (this.elevator.visible) {
                    this.toggleElevator(false);
                    fetch('close', {});
                }
            } else if (event.which == 13) {
                if (this.furniture.isMoving) {
                    this.confirmBuyFurniture();
                }
            } else if (event.which == 20) {
                if (!this.furniture.visible) return;

                fetch('toggleFurnitureFocus', {});
            }
        },

        handleOnKeyDown: function(event) {
            if (event.which == 72) {
                if (!this.gizmoMode) return;
                fetch('toggleFurnitureModeh');
            }
        },

        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--;
            }
        },
        
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++;
            }
        },
    },
    mounted() {
        this.listener = window.addEventListener('message', (event) => {
            const item = event.data;
            switch (item.action) {
                case 'toggleManagement':
                    this.houseList = item.houseList;
                    this.ToggleManagement(item.state);
                break;
                case 'updateManagement':
                    if (this.menu.management) {
                        this.houseList = item.houseList;
                    }
                break;
                case 'toggleHouseMenu':
                    this.showHousePanel(item);
                    break;
                case 'controls': 
                    if (!item || !item.keys) {
                        this.controlsHelp.visible = false;
                        return
                    }
                    this.ControlsNotify(item.keys, item.title);
                break;
                case 'preview':
                    if (item.show) {
                        let items = [];
                        switch(item.type) {
                            case 'exteriors':
                                items = this.exteriors;
                            break;
                        }
                        this.previewOptions(items, item.path, item.title);
                    } else {
                        this.closePreview();
                    }
                break;
                case 'setLoading':
                    this.loading = item.state;
                break;
                case 'setInfo':
                    this.info.visible = item.state;
                    if (item.text) {
                        this.info.text = item.text;
                    }
                break;
                case 'buyHouse':
                    this.buyHouse(item.data, item.garage);
                break;
                case 'toggleFurnitureMenu':
                    this.toggleFurnitureMenu(item.state);

                    if (item.furniture) {
                        this.furniture.buyedItems = item.furniture;
                    }
                break;
                case 'toggleFurnitureMoving':
                    this.furniture.isMoving = item.state;
                break;

                case 'toggleGizmoMode':
                    this.gizmoMode = item.state || !this.gizmoMode;
                break;

                case 'togglePreviewOpacity': 
                    this.togglePreviewOpacity(item.state);
    
                    if (this.menu.preview.visible) {
                        this.ControlsNotify([
                            {key: 'E', text: this.translations.view},
                            {key: 'ENTER', text: this.translations.confirm}
                        ])
                    }
                break;
    
                case 'playAlarm':
                    this.PlayAlarm();
                    break;
    
                case 'updateAlarm':
                    this.UpdateAlarm(item.volume);
                    break;
    
                case 'stopAlarm':
                    this.StopAlarm();
                break;
    
                case 'toggleHousesMenu':
                    this.ToggleHousesMenu(item.show, item.houses, item.focus);
                break;
                case 'updateFurnitureData':
                    this.furniture.selectedEntity = item.entity;
                    this.furniture.isMoving = true;
                break;
                case 'toggleElevator':
                    this.toggleElevator(item);
                break;
            }
        });

        window.addEventListener('keyup', this.handleOnKeyUp);
        window.addEventListener('keydown', this.handleOnKeyDown);

        fetch('getAllData', {}).then((data) => {
            this.exteriors = data.exteriors;
            this.shells = data.shells;
            this.ipls = data.ipls;
            this.translations = data.translations;
            this.furniture.categories = data.furnitureCategories;
            this.furniture.items = data.furnitureItems;
            this.house.upgrades = data.upgrades;
            this.house.doorLimit = data.doorLimit;
            this.allowedExtensions = data.allowedExtensions;
            this.stages = data.stages;
            this.furniture.defaultPrice = data.defaultPrice;
            this.paymentMethods = data.paymentMethods;
        });
    },
    beforeDestroy() {
        window.removeEventListener('message', this.listener);
        window.removeEventListener('keyup', this.handleOnKeyUp);
        window.removeEventListener('keydown', this.handleOnKeyDown);
    },
});

$(document).on('mouseenter', '.btn-sound', function () {
    s_over.currentTime = '0';
    s_over.play();
});

$(document).on('click', '.btn-sound', function () {
    s_click.currentTime = '0';
    s_click.play();
});

$(document).on('click', '.house_types .btn.option', function() {
    const this_ = $(this);
    let type = this_.attr('type');
    $('.house_types .btn.option').removeClass('active');
    $(`.house_types .btn.option[type="${type}"]`).addClass('active');
    if (type == 'mlo') {
        $('.construction-content').hide(150);
        $('.allow-vehicles').addClass('disabled');
        $('.check-allowvehicles').prop('checked', false).prop('disabled', true);
        $('.int_categories').hide(150);
    } else if (type == 'ipl') {
        $('.construction-content').show(150);
        $('.allow-vehicles').removeClass('disabled');
        $('.check-allowvehicles').prop('disabled', false);
        $('.int_categories').hide(150);
    } else {
        $('.construction-content').show(150);
        $('.allow-vehicles').removeClass('disabled');
        $('.check-allowvehicles').prop('disabled', false);
        $('.int_categories').show(150);
    }
});

$(document).on('click', '.door_types .btn.option', function() {
    const this_ = $(this);
    let type = this_.attr('type');
    $('.door_types .btn.option').removeClass('active');
    $(`.door_types .btn.option[type="${type}"]`).addClass('active');
});

$(document).on('click', '.creation_types .btn.option', function() {
    const this_ = $(this);
    let type = this_.attr('type');
    $('.creation_types .btn.option').removeClass('active');
    $(`.creation_types .btn.option[type="${type}"]`).addClass('active');
});

$(document).on('click', '.interior_categories .btn.option', function() {
    const this_ = $(this);
    let type = this_.attr('type');
    $('.interior_categories .btn.option').removeClass('active');
    $(`.interior_categories .btn.option[type="${type}"]`).addClass('active');
});

$(document).on('click', '.payment-method .btn.option', function() {
    const this_ = $(this);
    let type = this_.attr('type');
    $('.payment-method .btn.option').removeClass('active');
    $(`.payment-method .btn.option[type="${type}"]`).addClass('active');
});

$(document).on("change", ".check-construction", function () {
    if ($(this).is(":checked")) {
        $(".construction-options").show(150);
    } else {
        $(".construction-options").hide(150);
    }
});

$(document).on('mousedown', function (e) {
    if ($(".furniture:hover").length) return;

    if (e.which == 1) {
        if (app.currentModal) return;
        if (app.furniture.isMoving && app.furniture.selectedEntity) {
            if (app.furniture.action == 'create') {
                app.confirmBuyFurniture();
            } else if (app.furniture.action == 'move') {
                fetch('onClick', {action: 'update'}).then((data) => {
                    if (data) {
                        app.furniture.selectedEntity = false;
                        app.furniture.isMoving = false;
                        app.furniture.currentObject = false;

                        fetch('cancelFurniturePurchase', {});
                    }
                });
            }
            app.gizmoMode = false;
            s_pop.currentTime = '0';
            s_pop.play();
        } else {
            fetch('onClick', {}).then((data) => {
                if (!data) return;
                app.furniture.selectedEntity = data;
                app.furniture.isMoving = true;
                s_pop.currentTime = '0';
                s_pop.play();
            });
        }
    }
});

$(document).on('mousemove', function (e) {
    if (app.furniture.isMoving) {
        fetch('onMove', {});
    }

    if ($(".furniture:hover").length) return;
    if (app.furniture.action == 'create') return;

    if (app.furniture.visible) fetch('onHover', {});
});

$(document).on("wheel", function (event) {
    if (!app.furniture.isMoving) {
        return;
    }

    fetch('onRotate', {direction: event.originalEvent.deltaY > 0 ? 'left' : 'right'});
});

$(document).on('mouseenter', '.upgrade', function (e) {
    e.preventDefault();
    const upgrade = $(this).data('upgrade');


    if (!app.house.upgrades[upgrade].locked) {
        return;
    }

    if (!app.upgrades.info.visible) {
        app.upgrades.info.visible = true;
    }

    if (app.house.upgrades[upgrade]) {
        app.upgrades.info.title = app.house.upgrades[upgrade].label;
        app.upgrades.info.text = app.house.upgrades[upgrade].description;
    }

    app.upgrades.info.position = $(this).offset().top + 'px';
});

$(document).on('mouseleave', '.upgrade', function (e) {
    e.preventDefault();

    if (app.upgrades.info.visible) {
        app.upgrades.info.visible = false;
    }
})