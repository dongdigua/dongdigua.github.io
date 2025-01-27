const fs = require('fs');
const path = require('path');
const { co2 } = require("@tgwf/co2");

const filePath = process.argv[2];

if (!filePath) {
    console.error('GIVE ME A FILE')
    process.exit(1);
}

const absolutePath = path.resolve(filePath);
const co2Emission = new co2({ model: "swd", version: 4 });

fs.stat(absolutePath, (err, stats) => {
    if (err) {
        console.error(`${err.message}`);
        process.exit(1);
    }
    estimatedCO2 = co2Emission.perByte(stats.size) * 1000; // g to mg
    //console.log(`${estimatedCO2}`);
    let htmlContent = fs.readFileSync(absolutePath, 'utf8');

    if (htmlContent.includes('SWD_CO2')) {
        htmlContent = htmlContent.replace(/SWD_CO2/g, estimatedCO2.toFixed(4));
        fs.writeFileSync(absolutePath, htmlContent, 'utf8');
    }
});