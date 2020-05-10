using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class MenuPrincipal : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public void Jugador2()
    {

        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);

    }

    public void Jugador1()
    {

        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 4);

    }


    public void CerrarJuego()
    {
        Application.Quit();
        Debug.Log("Salir");
    }
}
