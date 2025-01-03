# 🗂️ **Script de Automatizare a Backup-urilor** 🔄

Acest script de **automatizare a backup-urilor** permite realizarea de copii de siguranță pentru directoarele specificate la intervale programate, utilizând **cron jobs**. 🕒 Scriptul oferă mai multe opțiuni de intervale pentru backup-uri, astfel încât să poți alege cum și când dorești să ruleze. De asemenea, include funcționalități de **retenție a backup-urilor**, eliminând automat fișierele mai vechi de un anumit număr de zile, și o opțiune de **restaurare a backup-urilor**. 🛠️

---

## 🎯 **Funcționalități** 🔥

- **Programarea automată a backup-urilor** folosind cron jobs. 📅
- **Intervale flexibile pentru backup**:
    - 🔁 **La fiecare minut** (nu este recomandat pentru uz frecvent).
    - 🕐 **La fiecare oră**.
    - 🌅 **La fiecare zi**.
    - 📅 **O dată pe săptămână** (poți selecta o zi a săptămânii).
    - 📆 **O dată pe lună** (poți selecta o zi a lunii).
- 🗑️ **Gestionarea retenției backup-urilor**: Șterge automat backup-urile mai vechi de un număr de zile specificat.
- 🔄 **Funcție de restaurare opțională**: Permite restaurarea unui backup într-o locație aleasă de tine.

---

## 🔐 **Retenția Backup-urilor** 🗑️

Scriptul va șterge automat backup-urile mai vechi de un anumit număr de zile, pe care îl poți configura după bunul plac. 

Exemplu: Dacă setezi **33 zile**, scriptul va șterge automat backup-urile mai vechi de 33 de zile.

---

## 🛠️ **Restaurare Backup** 🔄

Dacă ai nevoie să restaurezi un backup, scriptul îți oferă posibilitatea de a alege un backup din directorul de backup și de a-l restaura într-o locație specificată.

---

## 📅 **Exemplu de Crontab** 🕒

Când scriptul este rulat, se va adăuga automat o sarcină în crontab pentru a rula backup-ul conform intervalului ales. De exemplu:

- **Backup la fiecare oră**:
    ```bash
    0 * * * * bash /home/utilizator/backup.sh >> /dev/null 2>&1
    ```

---

