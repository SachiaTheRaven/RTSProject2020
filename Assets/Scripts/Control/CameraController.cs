
using UnityEngine;
namespace RTSGame
{
    public class CameraController : MonoBehaviour
    {
        // Start is called before the first frame update
        float rotationSpeed = 2.5f;
        public float panSpeed = 20f;
        public float panBorderThickness = 10f;
        public Vector2 panLimit = new Vector2(5, 5);
        public Vector2 scrollLimit = new Vector2(20, 120);
        Vector2 startPosition;
        public float scrollSpeed = 20f;
        private float currentScroll = 0;
        void Start()
        {
            startPosition = new Vector2(transform.position.x, transform.position.z);
        }

        // Update is called once per frame
        void Update()
        {
            MoveCamera();
        }

        public void MoveCamera()
        {
            //move the camera around with keys
            Vector3 pos = transform.position;

            // Vector3 offset = new Vector3(Input.GetAxis("Horizontal"), 0.0f, Input.GetAxis("Vertical")).normalized * cameraSpeed;
            //transform.Translate(offset);
            if (Input.GetKey(KeyCode.W) || Input.mousePosition.y >= Screen.height - panBorderThickness)
            {
                pos.z += panSpeed * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.S) || Input.mousePosition.y <= panBorderThickness)
            {
                pos.z -= panSpeed * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.D) || Input.mousePosition.x >= Screen.width - panBorderThickness)
            {
                pos.x += panSpeed * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.A) || Input.mousePosition.x <= panBorderThickness)
            {
                pos.x -= panSpeed * Time.deltaTime;
            }


            //zoom I guess
            float mouseWheel = Input.GetAxis("Mouse ScrollWheel");
            float scroll = Mathf.Abs(currentScroll) > Mathf.Abs(mouseWheel) ? currentScroll : mouseWheel;

            pos.y += scroll * scrollSpeed  * Time.deltaTime;


            pos.x = Mathf.Clamp(pos.x, startPosition.x - panLimit.x, startPosition.x + panLimit.x);
            pos.z = Mathf.Clamp(pos.z, startPosition.y - panLimit.y, startPosition.y + panLimit.y);
            pos.y = Mathf.Clamp(pos.y, scrollLimit.x, scrollLimit.y);

            transform.position = pos;
            currentScroll = 0;

        }

        public void OnGUI()
        {
            if (Event.current.type == EventType.ScrollWheel)  currentScroll = Event.current.delta.y;
        }

    }
}