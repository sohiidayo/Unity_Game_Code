using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseGame : MonoBehaviour
{
    private bool isPaused = false;
    public GameObject PauseMenu;
    public GameObject WinMenu;
    public GameObject LostMenu;
    private GlobalValueManager globalValueManager;
    private WaveManager waveManager;
    public bool noOver = true;
    void Update()
    {if (noOver)
        {
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                if (!isPaused)
                {
                    Pause();
                }
                else
                {
                    Resume();
                }
            }
            if (noOver)
            {
                if (globalValueManager.MonsterCount == 0 && waveManager.isWin)
                {
                    Win();
                }
                if (globalValueManager.hp < 1)
                {
                    lost();
                }
            }
        }
    }

    private void Start()
    {
        Resume();
        GameObject globalValueManagerObject = GameObject.Find("GlobalManager");
        globalValueManager = globalValueManagerObject.GetComponent<GlobalValueManager>();
        waveManager = globalValueManagerObject.GetComponent<WaveManager>();
    }

    public void Pause()
    {
        if (noOver) 
        {
            isPaused = true;
            Time.timeScale = 0f;  
            PauseMenu.SetActive(true);
        }
    }

    public void Resume()
    {
        if (noOver)
        {
            isPaused = false;
            Time.timeScale = 1f;
            PauseMenu.SetActive(false);
        }
    }

    public void ReloadScene()
    {
        // ��ȡ��ǰ����������  
        string currentSceneName = SceneManager.GetActiveScene().name;
        // ���ص�ǰ�������⽫���³��������¼���  
        SceneManager.LoadScene(currentSceneName);
    }
    public void Win() 
    {
        noOver = false;
        Time.timeScale = 0f;
        WinMenu.SetActive(true);
    }
    public void lost()
    {
        noOver = false;
        Time.timeScale = 0f;
        LostMenu.SetActive(true);
    }


}