const hbjs = require('handbrake-js');
const fs = require('fs');

const videoPath = './sample.mp4'; // Replace with the path to your sample video

exports.handler = async () => {
    try {
        console.log('Encoding started...')
        hbjs.spawn({
            input: videoPath,
            output: 'output.mp4',
            // Optional HandBrake settings, adjust as needed
            encoder: 'x264', // Specify video encoder (default)
            quality: 20 // Adjust video quality (1-100, lower is better)
        }).on('progress', progress => {
            console.log(
                'Percent complete: %s, ETA: %s',
                progress.percentComplete,
                progress.eta
            )
        }).on('error', error => {
            console.error('Error:', error);
        }).on('end', () => {
            console.log('Encoding completed successfully!');
        });

    } catch (error) {
        console.error('Error:', error);
    }
};
