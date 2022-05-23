import logging
import logging.config


def get_logger(name):
    logging.config.fileConfig('log.conf')
    return logging.getLogger(name)
