using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball_Controller : MonoBehaviour {

    private Rigidbody2D rb;
   

    // Use this for initialization
    void Start () {

       
        rb = GetComponent<Rigidbody2D>();
        rb.velocity = new Vector2(5f, 5f);

        StartCoroutine(Pause());

    }
	
 //Update is called once per frame
	void Update () {
        if(this.transform.position.x >= 17f)
        {
            this.transform.position = new Vector3(0f, 0f, 0f);
            StartCoroutine(Pause());
        }
        if (this.transform.position.x <= -17f)
        {
            this.transform.position = new Vector3(0f, 0f, 0f);
            StartCoroutine(Pause());
       }


    }






    IEnumerator Pause()
    {
      

        rb.velocity = new Vector2(0f, 0f);
        yield return new WaitForSeconds(2);
        rb.velocity = new Vector2(6f, 6f);

    }
}
