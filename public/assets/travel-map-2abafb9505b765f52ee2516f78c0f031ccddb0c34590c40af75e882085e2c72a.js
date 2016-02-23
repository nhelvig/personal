var map = AmCharts.makeChart("mapdiv",{
    type: "map",
    theme: "dark",
    projection: "mercator",
    panEventsEnabled : true,
    backgroundColor : "#535364",
    backgroundAlpha : 1,
    zoomControl: {
        zoomControlEnabled : true
    },
    dataProvider : {
        map : "worldHigh",
        getAreasFromMap : true,
        areas :
            [
                {
                    "id": "AT",
                    "showAsSelected": true
                },
                {
                    "id": "BE",
                    "showAsSelected": true
                },
                {
                    "id": "CH",
                    "showAsSelected": true
                },
                {
                    "id": "CZ",
                    "showAsSelected": true
                },
                {
                    "id": "DE",
                    "showAsSelected": true
                },
                {
                    "id": "DK",
                    "showAsSelected": true
                },
                {
                    "id": "ES",
                    "showAsSelected": true
                },
                {
                    "id": "FR",
                    "showAsSelected": true
                },
                {
                    "id": "HU",
                    "showAsSelected": true
                },
                {
                    "id": "IS",
                    "showAsSelected": true
                },
                {
                    "id": "IT",
                    "showAsSelected": true
                },
                {
                    "id": "NL",
                    "showAsSelected": true
                },
                {
                    "id": "NO",
                    "showAsSelected": true
                },
                {
                    "id": "PT",
                    "showAsSelected": true
                },
                {
                    "id": "SE",
                    "showAsSelected": true
                },
                {
                    "id": "SI",
                    "showAsSelected": true
                },
                {
                    "id": "CA",
                    "showAsSelected": true
                },
                {
                    "id": "HT",
                    "showAsSelected": true
                },
                {
                    "id": "US",
                    "showAsSelected": true
                },
                {
                    "id": "BR",
                    "showAsSelected": true
                },
                {
                    "id": "EC",
                    "showAsSelected": true
                },
                {
                    "id": "PE",
                    "showAsSelected": true
                },
                {
                    "id": "MW",
                    "showAsSelected": true
                },
                {
                    "id": "IN",
                    "showAsSelected": true
                }
            ]
    },
    areasSettings : {
        autoZoom : true,
        color : "#B4B4B7",
        colorSolid : "#84ADE9",
        selectedColor : "#84ADE9",
        outlineColor : "#666666",
        rollOverColor : "#9DEFF5",
        rollOverOutlineColor : "#000000"
    }
});
