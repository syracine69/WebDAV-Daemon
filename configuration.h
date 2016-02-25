#ifndef WEBDAV_CONFIGURATION_H
#define WEBDAV_CONFIGURATION_H

#include <time.h>

//////////////////////////////////////
// Webdavd Configuration Structures //
//////////////////////////////////////

typedef struct DaemonConfig {
	int port;
	const char * host;
	int sslEnabled;
	int forwardToIsEncrypted;
	int forwardToPort;
	const char * forwardToHost;
} DaemonConfig;

typedef struct SSLConfig {
	int chainFileCount;
	const char * keyFile;
	const char * certificateFile;
	const char ** chainFiles;

} SSLConfig;

typedef struct WebdavdConfiguration {
	// TODO restrict to user
	const char * restrictedUser;

	// Daemons
	int daemonCount;
	DaemonConfig * daemons;
	int maxConnectionsPerIp;

	// RAP
	time_t rapMaxSessionLife;
	int rapTimeoutRead;
	const char * pamServiceName;

	// files
	const char * mimeTypesFile;
	const char * rapBinary;
	const char * accessLog;
	const char * errorLog;
	const char * staticResponseDir;

	// SSL
	int sslCertCount;
	SSLConfig * sslCerts;
} WebdavdConfiguration;

extern WebdavdConfiguration config;

//////////////////////////////////////////
// End Webdavd Configuration Structures //
//////////////////////////////////////////

void configure(WebdavdConfiguration ** config, int * configCount, const char * configFile);
void freeConfigurationData(WebdavdConfiguration * configData);

#define CONFIG_NAMESPACE "http://couling.me/webdavd"

#endif
