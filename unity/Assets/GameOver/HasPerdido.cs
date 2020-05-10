using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class HasPerdido : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}

    // Update is called once per frame
    public void Volver()
    {
        // Debug.Log("SALOR");
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 5);
    }
}
