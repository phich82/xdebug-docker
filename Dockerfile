FROM php:7.4-apache 

# Update image
RUN apt-get update && apt-get install -y

# Install Xdebug
# php7.1 => xdebug-2.9.8 | php7.4 => xdebug-3.0.4
RUN curl -fsSL 'https://xdebug.org/files/xdebug-3.0.4.tgz' -o xdebug.tar.gz \
    && mkdir -p xdebug \
    && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
    && rm xdebug.tar.gz \
    && ( \
    cd xdebug \
    && phpize \
    && ./configure --enable-xdebug \
    && make -j$(nproc) \
    && make install \
    ) \
    && rm -r xdebug \
    && docker-php-ext-enable xdebug

# Copy php.ini into image
COPY php.ini.sample /usr/local/etc/php/php.ini