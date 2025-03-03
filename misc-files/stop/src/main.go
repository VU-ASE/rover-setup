package main

import (
	"time"
	"vu/ase/stopper/src/drivers/pca9685"
	"github.com/rs/zerolog/log"
)

var pca *pca9685.PCA9685Controller

// Used to start the program with the correct arguments
func main() {
	log.Info().Msg("Sending idle commands to servo and motor")

	// Connect to the PCA9685
	pca, err := pca9685.NewPCA9685Controller(0x40, 3)
	if err != nil {
		log.Error().Err(err).Msg("Failed to Initialize pca driver!")
		return
	}
	defer pca.Close()
	
	pca.AllOff()
	pca.SetFan(0)
	time.Sleep(50 * time.Millisecond)
	log.Info().Msg("Shutdown successful")
}
